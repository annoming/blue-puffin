// 将环境变量注入到 app，供 src/config/env.ts 读取
// 运行前可执行: export EXPO_PUBLIC_ZHIPU_API_KEY=你的key
const { expo } = require('./app.json');
module.exports = {
  ...expo,
  extra: {
    ZHIPU_API_KEY: process.env.EXPO_PUBLIC_ZHIPU_API_KEY ?? '',
    AI_PROVIDER: process.env.EXPO_PUBLIC_AI_PROVIDER ?? 'zhipu',
  },
};
