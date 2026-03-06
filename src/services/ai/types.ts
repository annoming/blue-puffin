/**
 * AI 服务统一类型定义，便于后续接入其他大模型
 */
export interface ChatMessage {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

export interface ChatCompletionOptions {
  messages: ChatMessage[];
  maxTokens?: number;
  temperature?: number;
  stream?: boolean;
}

export interface ChatCompletionResult {
  content: string;
  model: string;
  usage?: { promptTokens: number; completionTokens: number; totalTokens: number };
}

export type AIModelId = 'zhipu-glm4-flash' | string;

export interface IAIService {
  readonly modelId: AIModelId;
  chat(options: ChatCompletionOptions): Promise<ChatCompletionResult>;
  /** 可选：流式输出，后续扩展 */
  chatStream?(options: ChatCompletionOptions): AsyncGenerator<string, void, unknown>;
}
