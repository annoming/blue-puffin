/**
 * 环境配置：API Key 等敏感信息请使用 .env 或 EAS Secrets，勿提交仓库
 * Expo 使用 EXPO_PUBLIC_ 前缀暴露给客户端
 */
import Constants from 'expo-constants';

const extra = (Constants.expoConfig?.extra ?? {}) as Record<string, string>;

export const config = {
  /** 智谱 AI API Key，从 open.bigmodel.cn 获取 */
  zhipuApiKey: extra.ZHIPU_API_KEY ?? process.env.EXPO_PUBLIC_ZHIPU_API_KEY ?? '',
  /** 当前使用的 AI 提供商 */
  aiProvider: (extra.AI_PROVIDER ?? process.env.EXPO_PUBLIC_AI_PROVIDER ?? 'zhipu') as 'zhipu' | 'openai' | 'other',
} as const;
