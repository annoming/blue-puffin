/**
 * 智谱 AI GLM-4.7-Flash 实现
 * 文档: https://open.bigmodel.cn/dev/api
 * 免费模型: GLM-4.7-Flash
 */
import type { ChatMessage, ChatCompletionOptions, ChatCompletionResult, IAIService } from './types';

const ZHIPU_BASE = 'https://open.bigmodel.cn/api/paas/v4';
// 智谱免费模型：glm-4-flash / glm-4.7-flash 等，以开放平台文档为准
const MODEL_GLM_4_FLASH = 'glm-4-flash';

export class ZhipuGLMService implements IAIService {
  readonly modelId = 'zhipu-glm4-flash';
  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  async chat(options: ChatCompletionOptions): Promise<ChatCompletionResult> {
    const { messages, maxTokens = 1024, temperature = 0.7 } = options;
    const response = await fetch(`${ZHIPU_BASE}/chat/completions`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${this.apiKey}`,
      },
      body: JSON.stringify({
        model: MODEL_GLM_4_FLASH,
        messages: messages.map((m) => ({ role: m.role, content: m.content })),
        max_tokens: maxTokens,
        temperature,
      }),
    });

    if (!response.ok) {
      const errText = await response.text();
      throw new Error(`Zhipu API error ${response.status}: ${errText}`);
    }

    const data = (await response.json()) as {
      choices?: Array<{ message?: { content?: string } }>;
      model?: string;
      usage?: { prompt_tokens: number; completion_tokens: number; total_tokens: number };
    };

    const content = data.choices?.[0]?.message?.content ?? '';
    return {
      content,
      model: data.model ?? MODEL_GLM_4_FLASH,
      usage: data.usage
        ? {
            promptTokens: data.usage.prompt_tokens,
            completionTokens: data.usage.completion_tokens,
            totalTokens: data.usage.total_tokens,
          }
        : undefined,
    };
  }
}
