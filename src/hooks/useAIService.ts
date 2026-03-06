import { useMemo } from 'react';
import { createAIService } from '@/services/ai';
import { config } from '@/config/env';
import type { IAIService } from '@/services/ai';

/**
 * 获取当前配置的 AI 服务实例（智谱 GLM-4-Flash 或后续扩展的其他模型）
 * 未配置 API Key 时返回 null，调用方需提示用户去设置页配置
 */
export function useAIService(): IAIService | null {
  return useMemo(() => {
    const key = config.zhipuApiKey;
    if (!key?.trim()) return null;
    return createAIService(config.aiProvider, key);
  }, []);
}
