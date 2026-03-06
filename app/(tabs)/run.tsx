import { View, Text, StyleSheet } from 'react-native';
import { colors, fontSizes } from '@/theme';

export default function RunScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>开始跑步</Text>
      <Text style={styles.hint}>AI 配速与训练指导、语音陪跑等核心功能将在此实现</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
    padding: 24,
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: {
    fontSize: fontSizes.xl,
    color: colors.primary,
    marginBottom: 16,
  },
  hint: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
    textAlign: 'center',
  },
});
