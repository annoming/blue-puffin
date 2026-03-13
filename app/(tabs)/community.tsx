import { View, Text, StyleSheet, ScrollView, Pressable } from 'react-native';
import { colors, fontSizes, fontWeights } from '@/theme';

/**
 * 社区 - 对齐 Puffinfigma 极简布局
 * 成就徽章 6 列、生成运动海报圆角按钮、跑友动态列表
 */
const BADGES = [
  { id: '1', name: '早鸟', unlocked: true },
  { id: '2', name: '破风', unlocked: true },
  { id: '3', name: '半马', unlocked: true },
  { id: '4', name: '百公里', unlocked: false },
  { id: '5', name: '全马', unlocked: false },
  { id: '6', name: '夜跑', unlocked: false },
];

const FEEDS = [
  { id: '1', user: '跑步小王', time: '2小时前', distance: '10.2', duration: '52:30', pace: '5:09', likes: 28, comments: 5 },
  { id: '2', user: '晨跑达人', time: '5小时前', distance: '5.8', duration: '31:45', pace: '5:28', likes: 42, comments: 8 },
  { id: '3', user: '马拉松小李', time: '昨天', distance: '21.1', duration: '1:48:22', pace: '5:08', likes: 156, comments: 23 },
];

export default function CommunityScreen() {
  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      {/* 头部 */}
      <View style={styles.header}>
        <Text style={styles.pageTitle}>社区</Text>
        <Text style={styles.pageSubtitle}>分享你的精彩瞬间</Text>
      </View>

      {/* 成就徽章 - 6 列圆，已解锁黑底白字 / 未解锁白底灰边 */}
      <View style={styles.badgesSection}>
        <Text style={styles.sectionLabel}>成就徽章</Text>
        <View style={styles.badgesGrid}>
          {BADGES.map((b) => (
            <View
              key={b.id}
              style={[styles.badgeCircle, b.unlocked ? styles.badgeUnlocked : styles.badgeLocked]}
            >
              <Text style={[styles.badgeText, !b.unlocked && styles.badgeTextLocked]}>
                {b.name}
              </Text>
            </View>
          ))}
        </View>
        <Text style={styles.unlockCount}>3 / 6 已解锁</Text>
      </View>

      {/* 生成运动海报 - 全宽圆角描边 */}
      <View style={styles.posterSection}>
        <Pressable style={styles.posterButton}>
          <Text style={styles.posterButtonText}>生成运动海报</Text>
        </Pressable>
      </View>

      {/* 跑友动态 */}
      <View style={styles.feedSection}>
        <Text style={styles.sectionLabel}>跑友动态</Text>
        {FEEDS.map((feed, index) => (
          <View
            key={feed.id}
            style={[
              styles.feedItem,
              index === FEEDS.length - 1 && styles.feedItemLast,
            ]}
          >
            <View style={styles.feedHeader}>
              <Text style={styles.feedUser}>{feed.user}</Text>
              <Text style={styles.feedTime}>{feed.time}</Text>
            </View>
            <View style={styles.feedStats}>
              <View style={styles.feedStat}>
                <Text style={styles.feedStatLabel}>距离</Text>
                <Text style={styles.feedStatValue}>{feed.distance} km</Text>
              </View>
              <View style={styles.feedStat}>
                <Text style={styles.feedStatLabel}>时长</Text>
                <Text style={styles.feedStatValue}>{feed.duration}</Text>
              </View>
              <View style={styles.feedStat}>
                <Text style={styles.feedStatLabel}>配速</Text>
                <Text style={styles.feedStatValue}>{feed.pace}</Text>
              </View>
            </View>
            <View style={styles.feedActions}>
              <Text style={styles.feedActionText}>♥ {feed.likes}</Text>
              <Text style={styles.feedActionText}>💬 {feed.comments}</Text>
              <Text style={[styles.feedActionText, styles.feedActionShare]}>分享</Text>
            </View>
          </View>
        ))}
        <Pressable style={styles.loadMore}>
          <Text style={styles.loadMoreText}>加载更多</Text>
        </Pressable>
      </View>
      <View style={styles.bottomPad} />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.white,
  },
  content: {
    paddingBottom: 24,
  },
  header: {
    paddingHorizontal: 24,
    paddingTop: 32,
    paddingBottom: 24,
  },
  pageTitle: {
    fontSize: fontSizes.xxl,
    color: colors.black,
    fontWeight: fontWeights.medium,
    marginBottom: 8,
  },
  pageSubtitle: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  badgesSection: {
    paddingHorizontal: 24,
    paddingBottom: 32,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray200,
  },
  sectionLabel: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
    marginBottom: 16,
  },
  badgesGrid: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    gap: 12,
  },
  badgeCircle: {
    flex: 1,
    aspectRatio: 1,
    maxWidth: 56,
    borderRadius: 9999,
    alignItems: 'center',
    justifyContent: 'center',
  },
  badgeUnlocked: {
    backgroundColor: colors.black,
  },
  badgeLocked: {
    backgroundColor: colors.white,
    borderWidth: 1,
    borderColor: colors.gray200,
  },
  badgeText: {
    fontSize: fontSizes.xs,
    color: colors.white,
  },
  badgeTextLocked: {
    color: colors.gray400,
  },
  unlockCount: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
    textAlign: 'center',
    marginTop: 16,
  },
  posterSection: {
    paddingHorizontal: 24,
    paddingVertical: 24,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray200,
  },
  posterButton: {
    width: '100%',
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 9999,
    paddingVertical: 12,
    alignItems: 'center',
  },
  posterButtonText: {
    fontSize: fontSizes.sm,
    color: colors.black,
  },
  feedSection: {
    paddingHorizontal: 24,
    paddingTop: 24,
  },
  feedItem: {
    paddingBottom: 32,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray200,
    marginBottom: 32,
  },
  feedItemLast: {
    borderBottomWidth: 0,
  },
  feedHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'baseline',
    marginBottom: 16,
  },
  feedUser: {
    fontSize: fontSizes.md,
    color: colors.black,
  },
  feedTime: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
  },
  feedStats: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 16,
    borderTopWidth: 1,
    borderBottomWidth: 1,
    borderColor: colors.gray200,
    marginBottom: 16,
  },
  feedStat: {
    flex: 1,
    alignItems: 'center',
  },
  feedStatLabel: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
    marginBottom: 4,
  },
  feedStatValue: {
    fontSize: fontSizes.xl,
    fontWeight: fontWeights.regular,
    color: colors.black,
  },
  feedActions: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 24,
  },
  feedActionText: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  feedActionShare: {
    marginLeft: 'auto',
  },
  loadMore: {
    alignItems: 'center',
    paddingVertical: 32,
  },
  loadMoreText: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  bottomPad: {
    height: 24,
  },
});
