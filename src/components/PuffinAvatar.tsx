import { View, Text, StyleSheet } from 'react-native';
import { colors, fontSizes } from '@/theme';

interface PuffinAvatarProps {
  size?: number;
  mood?: 'idle' | 'running' | 'celebrate';
}

/**
 * 小海鹦 Blue Puffin 虚拟形象占位
 * 后续可替换为 Lottie/图片/SVG 动画
 */
export function PuffinAvatar({ size = 64, mood = 'idle' }: PuffinAvatarProps) {
  return (
    <View style={[styles.avatar, { width: size, height: size, borderRadius: size / 2 }]}>
      <Text style={[styles.emoji, { fontSize: size * 0.5 }]}>🐧</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  avatar: {
    backgroundColor: colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
  },
  emoji: {},
});
