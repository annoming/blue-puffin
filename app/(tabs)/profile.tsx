import { View, Text, StyleSheet, ScrollView, Pressable, Image } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors, fontSizes, fontWeights } from '@/theme';

/**
 * 我的 - 对齐 Puffinfigma 极简布局
 * 个人信息、装备库、商城、语音包、设置
 */
const SETTINGS_ITEMS = [
  { label: '消息通知', badge: null },
  { label: '目标设置', badge: null },
  { label: '数据报告', badge: '每周' },
  { label: '隐私设置', badge: null },
  { label: '帮助与反馈', badge: null },
  { label: '关于我们', badge: 'v2.1.0' },
];

export default function ProfileScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView contentContainerStyle={styles.content}>
        {/* 个人信息 - 极简 */}
        <View style={styles.profileSection}>
          <View style={styles.profileRow}>
            <Image source={require('../../assets/icon.png')} style={styles.avatar} />
            <View>
              <Text style={styles.userName}>跑步达人</Text>
              <Text style={styles.userLevel}>Level 8</Text>
            </View>
          </View>
          <View style={styles.statsRow}>
            <View style={styles.stat}>
              <Text style={styles.statValue}>286</Text>
              <Text style={styles.statLabel}>总跑量 km</Text>
            </View>
            <View style={styles.stat}>
              <Text style={styles.statValue}>24.5</Text>
              <Text style={styles.statLabel}>总时长 h</Text>
            </View>
            <View style={styles.stat}>
              <Text style={styles.statValue}>18k</Text>
              <Text style={styles.statLabel}>消耗 kcal</Text>
            </View>
          </View>
        </View>

        {/* 装备库 */}
        <View style={styles.section}>
          <Text style={styles.sectionLabel}>装备库</Text>
          <Pressable style={styles.gearRow}>
            <View style={styles.gearMain}>
              <Text style={styles.gearName}>Nike Air Zoom Pegasus</Text>
              <View style={styles.gearProgressRow}>
                <View style={styles.progressBarBg}>
                  <View style={[styles.progressBarFill, { width: '65%' }]} />
                </View>
                <Text style={styles.progressText}>260/400 km</Text>
              </View>
            </View>
            <Text style={styles.chevron}>›</Text>
          </Pressable>
          <Pressable style={styles.gearRow}>
            <View style={styles.gearMain}>
              <Text style={styles.gearName}>智能运动手表</Text>
              <Text style={styles.gearSub}>已连接 · 85%</Text>
            </View>
            <Text style={styles.chevron}>›</Text>
          </Pressable>
          <Pressable style={styles.addGearBtn}>
            <Text style={styles.addGearText}>+ 添加装备</Text>
          </Pressable>
        </View>

        {/* 商城 */}
        <View style={styles.section}>
          <Text style={styles.sectionLabel}>商城</Text>
          <View style={styles.storeGrid}>
            {[
              { name: '运动T恤', price: '¥199' },
              { name: '遮阳帽', price: '¥89' },
              { name: '运动水壶', price: '¥129' },
              { name: '虚拟贴纸', price: '¥19' },
            ].map((item, i) => (
              <Pressable key={i} style={styles.storeCard}>
                <Text style={styles.storeName}>{item.name}</Text>
                <Text style={styles.storePrice}>{item.price}</Text>
              </Pressable>
            ))}
          </View>
        </View>

        {/* 语音包 */}
        <View style={styles.section}>
          <Text style={styles.sectionLabel}>语音包</Text>
          <View style={[styles.voiceRow, styles.voiceRowActive]}>
            <View>
              <Text style={styles.voiceTitle}>元气陪伴模式</Text>
              <Text style={styles.voiceSub}>温柔鼓励</Text>
            </View>
            <View style={styles.voiceDot} />
          </View>
          <Pressable style={styles.voiceRow}>
            <View>
              <Text style={styles.voiceTitle}>严厉教练模式</Text>
              <Text style={styles.voiceSub}>专业指导</Text>
            </View>
            <Text style={styles.chevron}>›</Text>
          </Pressable>
          <Pressable style={styles.voiceRow}>
            <View>
              <Text style={styles.voiceTitle}>音乐节奏模式</Text>
              <Text style={styles.voiceSub}>律动跑步</Text>
            </View>
            <View style={styles.proBadge}>
              <Text style={styles.proBadgeText}>PRO</Text>
            </View>
          </Pressable>
        </View>

        {/* 设置 */}
        <View style={styles.section}>
          <Text style={styles.sectionLabel}>设置</Text>
          {SETTINGS_ITEMS.map((item, i) => (
            <Pressable
              key={i}
              style={styles.settingsRow}
            >
              <Text style={styles.settingsLabel}>{item.label}</Text>
              <View style={styles.settingsRight}>
                {item.badge && (
                  <Text style={styles.settingsBadge}>{item.badge}</Text>
                )}
                <Text style={styles.chevron}>›</Text>
              </View>
            </Pressable>
          ))}
        </View>
        <View style={styles.bottomPad} />
      </ScrollView>
    </SafeAreaView>
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
  profileSection: {
    paddingHorizontal: 24,
    paddingTop: 32,
    paddingBottom: 32,
  },
  profileRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 16,
    marginBottom: 32,
  },
  avatar: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: colors.gray200,
  },
  userName: {
    fontSize: fontSizes.xl,
    color: colors.black,
    marginBottom: 4,
  },
  userLevel: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  statsRow: {
    flexDirection: 'row',
    gap: 24,
  },
  stat: {
    flex: 1,
  },
  statValue: {
    fontSize: 30,
    fontWeight: fontWeights.regular,
    color: colors.black,
  },
  statLabel: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
    marginTop: 4,
  },
  section: {
    paddingHorizontal: 24,
    paddingVertical: 24,
    borderTopWidth: 1,
    borderTopColor: colors.gray200,
  },
  sectionLabel: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
    marginBottom: 16,
  },
  gearRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 12,
  },
  gearMain: {
    flex: 1,
  },
  gearName: {
    fontSize: fontSizes.md,
    color: colors.black,
    marginBottom: 8,
  },
  gearSub: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  gearProgressRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  progressBarBg: {
    height: 4,
    width: 96,
    backgroundColor: colors.gray200,
    borderRadius: 2,
    overflow: 'hidden',
  },
  progressBarFill: {
    height: '100%',
    backgroundColor: colors.black,
    borderRadius: 2,
  },
  progressText: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
  },
  chevron: {
    fontSize: 16,
    color: colors.gray600,
  },
  addGearBtn: {
    borderWidth: 1,
    borderStyle: 'dashed',
    borderColor: colors.gray200,
    borderRadius: 8,
    paddingVertical: 16,
    alignItems: 'center',
    marginTop: 8,
  },
  addGearText: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  storeGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 16,
  },
  storeCard: {
    width: '47%',
    borderWidth: 1,
    borderColor: colors.gray200,
    borderRadius: 8,
    padding: 16,
  },
  storeName: {
    fontSize: fontSizes.md,
    color: colors.black,
    marginBottom: 8,
  },
  storePrice: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  voiceRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 12,
    paddingLeft: 16,
  },
  voiceRowActive: {
    borderLeftWidth: 2,
    borderLeftColor: colors.black,
  },
  voiceTitle: {
    fontSize: fontSizes.md,
    color: colors.black,
    marginBottom: 4,
  },
  voiceSub: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
  voiceDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: colors.black,
  },
  proBadge: {
    paddingHorizontal: 8,
    paddingVertical: 2,
    borderWidth: 1,
    borderColor: colors.black,
    borderRadius: 4,
  },
  proBadgeText: {
    fontSize: fontSizes.xs,
    color: colors.black,
  },
  settingsRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 12,
  },
  settingsLabel: {
    fontSize: fontSizes.sm,
    color: colors.black,
  },
  settingsRight: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  settingsBadge: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
  },
  bottomPad: {
    height: 32,
  },
});
