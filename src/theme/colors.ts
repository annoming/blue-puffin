/**
 * Blue Puffin 品牌配色
 * 主色：科技蓝 辅色：活力橙 背景：纯白 + 极浅冰川灰
 */
export const colors = {
  primary: '#1DA1F2',
  primaryDark: '#0d8bd9',
  secondary: '#FF9F00',
  secondaryLight: '#ffb733',
  white: '#FFFFFF',
  glacier: '#F0F7FC',       // 极浅冰川灰，北极氛围
  gray100: '#F5F5F5',
  gray200: '#EEEEEE',
  gray300: '#E0E0E0',
  gray400: '#BDBDBD',
  gray600: '#757575',
  gray800: '#424242',
  black: '#212121',
  success: '#4CAF50',
  warning: '#FF9800',
  error: '#F44336',
  background: '#FAFAFA',
  card: '#FFFFFF',
} as const;

export type ColorKey = keyof typeof colors;
