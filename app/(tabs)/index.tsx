import { View, Text, StyleSheet } from 'react-native';
import { colors, fontSizes, fontWeights } from '@/theme';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>步凡，与你同行</Text>
      <Text style={styles.subtitle}>Run with Blue Puffin</Text>
      <Text style={styles.hint}>小海鹦在这里陪你跑步～ 核心功能开发中</Text>
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
    fontSize: fontSizes.xxl,
    fontWeight: fontWeights.bold,
    color: colors.primary,
    marginBottom: 8,
  },
  subtitle: {
    fontSize: fontSizes.md,
    color: colors.gray600,
    marginBottom: 32,
  },
  hint: {
    fontSize: fontSizes.sm,
    color: colors.gray400,
  },
});
