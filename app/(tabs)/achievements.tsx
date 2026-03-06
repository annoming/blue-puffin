import { View, Text, StyleSheet } from 'react-native';
import { colors, fontSizes } from '@/theme';

export default function AchievementsScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>成就徽章</Text>
      <Text style={styles.hint}>跑步排行榜与成就解锁功能将在此实现</Text>
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
    color: colors.secondary,
    marginBottom: 16,
  },
  hint: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
    textAlign: 'center',
  },
});
