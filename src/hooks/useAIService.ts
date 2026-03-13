import { useMemo } from 'react';
import { createAIService } from '@/services/ai';
import { config } from '@/config/env';
import type { IAIService } from '@/services/ai';

/**
 * 获取 AI 服务实例（由后台统一接入，客户端固定使用当前配置）
 * 未配置 API Key 时返回 null，调用方需提示用户或走后端代理
 */
export function useAIService(): IAIService | null {
  return useMemo(() => {
    const key = config.zhipuApiKey;
    if (!key?.trim()) return null;
    return createAIService('zhipu', key);
  }, []);
}
