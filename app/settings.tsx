import { View, Text, StyleSheet, Pressable } from 'react-native';
import { router } from 'expo-router';
import { colors, fontSizes } from '@/theme';

export default function SettingsScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>设置</Text>
      <Text style={styles.hint}>智谱 API Key 配置、切换其他大模型等将在此实现</Text>
      <Pressable style={styles.button} onPress={() => router.back()}>
        <Text style={styles.buttonText}>返回</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
    padding: 24,
  },
  title: {
    fontSize: fontSizes.xl,
    color: colors.primary,
    marginBottom: 16,
  },
  hint: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
    marginBottom: 24,
  },
  button: {
    backgroundColor: colors.gray200,
    padding: 16,
    borderRadius: 12,
    alignItems: 'center',
  },
  buttonText: {
    color: colors.gray800,
    fontSize: fontSizes.md,
  },
});
