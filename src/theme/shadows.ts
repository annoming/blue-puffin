import { Platform } from 'react-native';

/** 卡片轻阴影 - 现代扁平风圆角卡片 */
export const cardShadow = Platform.select({
  ios: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.06,
    shadowRadius: 8,
  },
  android: { elevation: 3 },
  default: {},
});

/** 按钮/悬浮元素稍强阴影 */
export const buttonShadow = Platform.select({
  ios: {
    shadowColor: '#1DA1F2',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.25,
    shadowRadius: 8,
  },
  android: { elevation: 4 },
  default: {},
});
