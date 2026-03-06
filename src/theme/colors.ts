/**
 * Blue Puffin 品牌配色
 * 主色：蓝色（科技感） 辅色：橙色（活泼） 点缀：白/灰
 */
export const colors = {
  primary: '#1DA1F2',
  primaryDark: '#0d8bd9',
  secondary: '#FF9F00',
  secondaryLight: '#ffb733',
  white: '#FFFFFF',
  gray100: '#F5F5F5',
  gray200: '#EEEEEE',
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
