/**
 * 环境配置：API Key 等敏感信息请使用 .env 或 EAS Secrets，勿提交仓库
 * 大模型由后台统一接入，客户端不提供切换入口
 */
import Constants from 'expo-constants';

const extra = (Constants.expoConfig?.extra ?? {}) as Record<string, string>;

export const config = {
  /** 智谱 AI API Key，从 open.bigmodel.cn 获取（或由后端代理时可不配） */
  zhipuApiKey: extra.ZHIPU_API_KEY ?? process.env.EXPO_PUBLIC_ZHIPU_API_KEY ?? '',
} as const;
