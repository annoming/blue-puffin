/**
 * AI 服务工厂：当前使用智谱 GLM-4-Flash，后续可扩展接入 OpenAI、通义等
 */
import type { IAIService } from './types';
import { ZhipuGLMService } from './zhipuGLMService';

export type AIModelProvider = 'zhipu' | 'openai' | 'other';

const defaultProvider: AIModelProvider = 'zhipu';

export function createAIService(
  provider: AIModelProvider = defaultProvider,
  apiKey: string
): IAIService {
  switch (provider) {
    case 'zhipu':
      return new ZhipuGLMService(apiKey);
    // case 'openai':
    //   return new OpenAIService(apiKey);
    default:
      return new ZhipuGLMService(apiKey);
  }
}
