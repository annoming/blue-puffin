import { colors, fontSizes, fontWeights } from '@/theme';
import { router } from 'expo-router';
import { useEffect, useMemo, useRef, useState } from 'react';
import {
  Animated,
  Image,
  Modal,
  Pressable,
  RefreshControl,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { SafeAreaView, useSafeAreaInsets } from 'react-native-safe-area-context';

const TAB_BAR_HEIGHT = 56;
const COUNTDOWN_SECONDS = 3;

/** 「点我」类说法：口语化 + 方言，不固定轮换 */
const TAP_PHRASES = [
  '点我一起',
  '戳我',
  '摁我',
  '点俺',
  '戳一下',
  '点一下',
  '点俺一起',
  '戳俺',
  '摁一下',
  '点我',
] as const;

/** 根据 AI 建议生成带「点我/戳我」等的展示句，tapPhrase 从 TAP_PHRASES 中选 */
function weaveTapHint(aiSuggestion: string, tapPhrase: string | undefined): string {
  const phrase = typeof tapPhrase === 'string' ? tapPhrase : '点我一起';
  const s = (aiSuggestion ?? '').trim();
  const withTogether = phrase.includes('一起') ? phrase : `${phrase}一起`;
  if (!s) return `${phrase}，一起开始跑步吧`;
  // 「适合xxx」→「点我一起/戳我一起xxx」
  if (s.includes('适合')) return s.replace(/适合/g, withTogether);
  // 「可以xxx」→「戳我，可以xxx」
  if (s.includes('可以')) return s.replace(/可以/, `${phrase}，可以`);
  // 「来xxx」→「戳我，来xxx」
  if (/来[^，。]*/.test(s)) return s.replace(/^(.*?)(来)/, `$1${phrase}，$2`);
  // 默认：句末前插入
  if (/[，。]$/.test(s)) return s.replace(/([，。])$/, `，${withTogether}开始吧$1`);
  return `${s}，${withTogether}开始吧`;
}

/**
 * 陪跑舱 - 状态/跑量 + 对话生成的训练·营养方案展示
 * 长按小海鹦图标倒计时 3 秒后进入跑步页
 */
export default function HomeScreen() {
  const insets = useSafeAreaInsets();
  const bottomPadding = Math.max(insets.bottom + TAB_BAR_HEIGHT, 100);
  const [countdown, setCountdown] = useState<number | null>(null);
  const [refreshing, setRefreshing] = useState(false);
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const pulseAnim = useRef(new Animated.Value(1)).current;

  /** 下拉同步手表数据（绑定手表后后台会自动同步，未实时成功时可在此手动同步） */
  const onRefresh = async () => {
    setRefreshing(true);
    try {
      // TODO: 调用同步手表数据接口，若未绑定手表可仅结束 loading 或提示未绑定
      await new Promise((r) => setTimeout(r, 800));
      // 同步后可在此更新本周跑量等展示数据
    } finally {
      setRefreshing(false);
    }
  };

  const cancelCountdown = () => {
    if (intervalRef.current) {
      clearInterval(intervalRef.current);
      intervalRef.current = null;
    }
    setCountdown(null);
  };

  useEffect(() => {
    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }
    };
  }, []);

  /** 小海鹦呼吸动效，提示可点击 */
  useEffect(() => {
    const breath = Animated.loop(
      Animated.sequence([
        Animated.timing(pulseAnim, {
          toValue: 1.06,
          duration: 1200,
          useNativeDriver: true,
        }),
        Animated.timing(pulseAnim, {
          toValue: 1,
          duration: 1200,
          useNativeDriver: true,
        }),
      ])
    );
    breath.start();
    return () => breath.stop();
  }, [pulseAnim]);

  useEffect(() => {
    if (countdown !== COUNTDOWN_SECONDS) return;
    intervalRef.current = setInterval(() => {
      setCountdown((prev) => {
        if (prev === null || prev <= 1) {
          if (intervalRef.current) {
            clearInterval(intervalRef.current);
            intervalRef.current = null;
          }
          if (prev === 1) router.push('/(tabs)/run');
          return null;
        }
        return prev - 1;
      });
    }, 1000);
    return () => { /* 不在 countdown 变化时清除，由上面或 setState 内清除 */ };
  }, [countdown]);

  const handleLongPress = () => {
    setCountdown(COUNTDOWN_SECONDS);
  };

  const handlePress = () => {
    router.push('/(tabs)/run');
  };

  // AI 建议（后续可改为接口返回），展示时自动融入「点我/戳我」等说法（每次进入随机一种）
  const aiSuggestion = '今天微风，适合创造新纪录';
  const tapPhrase = useMemo(
    () => TAP_PHRASES[Math.floor(Math.random() * TAP_PHRASES.length)] ?? TAP_PHRASES[0],
    []
  );
  const motivationText = weaveTapHint(aiSuggestion, tapPhrase);

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView
        style={styles.scroll}
        contentContainerStyle={[styles.scrollContent, { paddingBottom: bottomPadding }]}
        showsVerticalScrollIndicator={false}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={onRefresh}
            tintColor={colors.gray600}
          />
        }
      >
        {/* 1. 顶部状态 */}
        <View style={styles.header}>
          <View>
            <Text style={styles.levelLabel}>Level 8</Text>
            <Text style={styles.levelTitle}>初级海鹦</Text>
          </View>
          <View style={styles.headerRight}>
            <Text style={styles.weatherLabel}>Today</Text>
            <Text style={styles.weatherValue}>18°C</Text>
          </View>
        </View>

        {/* 2. 小海鹦 + 一句话（长按倒计时 3 秒进入跑步） */}
        <View style={styles.hero}>
          <Pressable
            onPress={handlePress}
            onLongPress={handleLongPress}
            style={({ pressed }) => [styles.puffinTouchable, pressed && styles.puffinTouchablePressed]}
          >
            <Animated.View style={[styles.puffinImageWrap, { transform: [{ scale: pulseAnim }] }]}>
              <Image
                source={require('../../assets/icon.png')}
                style={styles.puffinImage}
                resizeMode="contain"
              />
            </Animated.View>
          </Pressable>
          <Text style={styles.motivation}>{motivationText}</Text>
        </View>

        {/* 倒计时浮层 */}
        <Modal visible={countdown !== null} transparent animationType="fade">
          <Pressable style={styles.countdownOverlay} onPress={cancelCountdown}>
            <View style={styles.countdownBox}>
              <Text style={styles.countdownNumber}>{countdown ?? ''}</Text>
              <Text style={styles.countdownHint}>点击任意处取消</Text>
            </View>
          </Pressable>
        </Modal>

        {/* 3. 本周跑量 */}
        <View style={styles.block}>
          <Text style={styles.blockLabel}>本周跑量</Text>
          <View style={styles.progressRow}>
            <Text style={styles.progressCurrent}>12.8</Text>
            <Text style={styles.progressTotal}>/ 20.0 km</Text>
          </View>
          <View style={styles.progressBarBg}>
            <View style={[styles.progressBarFill, { width: '64%' }]} />
          </View>
        </View>

        {/* 4. 训练计划（对话生成展示） */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>训练计划</Text>
          <View style={styles.guidance}>
            <Text style={styles.guidanceText}>
              昨天的配速有些下降，今天专注心率控制，保持在 140-150 bpm
            </Text>
          </View>
          <View style={styles.trainingCard}>
            <Text style={styles.cardTitle}>轻松跑</Text>
            <Text style={styles.cardSubtitle}>有氧训练 · 恢复期</Text>
            <View style={styles.metricsRow}>
              <View style={styles.metric}>
                <Text style={styles.metricValue}>5.0</Text>
                <Text style={styles.metricUnit}>km</Text>
              </View>
              <View style={styles.metric}>
                <Text style={styles.metricValue}>6:00</Text>
                <Text style={styles.metricUnit}>/km</Text>
              </View>
              <View style={styles.metric}>
                <Text style={styles.metricValue}>30</Text>
                <Text style={styles.metricUnit}>min</Text>
              </View>
            </View>
          </View>
          <View style={styles.trainingCard}>
            <Text style={styles.cardTitle}>间歇跑训练</Text>
            <Text style={styles.cardSubtitle}>速度提升 · 高强度</Text>
            <View style={styles.metricsRow}>
              <View style={styles.metric}>
                <Text style={styles.metricValue}>8.0</Text>
                <Text style={styles.metricUnit}>km</Text>
              </View>
              <View style={styles.metric}>
                <Text style={styles.metricValue}>4:30</Text>
                <Text style={styles.metricUnit}>/km</Text>
              </View>
              <View style={styles.metric}>
                <Text style={styles.metricValue}>6x400</Text>
                <Text style={styles.metricUnit}>组数</Text>
              </View>
            </View>
          </View>
        </View>

        {/* 5. 营养方案（对话生成展示） */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>营养方案</Text>
          <View style={styles.nutritionCard}>
            <View style={styles.nutritionRow}>
              <View>
                <Text style={styles.nutritionTitle}>跑前补水</Text>
                <Text style={styles.nutritionSub}>运动前 30 分钟</Text>
              </View>
              <Text style={styles.nutritionValue}>300ml</Text>
            </View>
            <View style={styles.nutritionRow}>
              <View>
                <Text style={styles.nutritionTitle}>能量补充</Text>
                <Text style={styles.nutritionSub}>香蕉或能量棒</Text>
              </View>
              <Text style={styles.nutritionValue}>1份</Text>
            </View>
            <View style={[styles.nutritionRow, styles.nutritionRowLast]}>
              <View>
                <Text style={styles.nutritionTitle}>跑后恢复餐</Text>
                <Text style={styles.nutritionSub}>蛋白质 + 碳水</Text>
              </View>
              <Text style={styles.nutritionValue}>1小时内</Text>
            </View>
          </View>
          <View style={styles.caloriesRow}>
            <Text style={styles.caloriesLabel}>今日热量消耗</Text>
            <Text style={styles.caloriesNum}>1,247 kcal</Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: colors.white },
  scroll: { flex: 1 },
  scrollContent: { paddingHorizontal: 20, flexGrow: 1 },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingTop: 12,
    paddingBottom: 8,
  },
  headerRight: { alignItems: 'flex-end' },
  levelLabel: { fontSize: fontSizes.sm, color: colors.gray600, marginBottom: 2 },
  levelTitle: { fontSize: fontSizes.lg, color: colors.black, fontWeight: fontWeights.medium },
  weatherLabel: { fontSize: fontSizes.sm, color: colors.gray600, marginBottom: 2 },
  weatherValue: { fontSize: fontSizes.lg, color: colors.black, fontWeight: fontWeights.medium },
  hero: {
    alignItems: 'center',
    marginTop: 12,
    marginBottom: 16,
  },
  puffinTouchable: { alignSelf: 'center' },
  puffinTouchablePressed: { opacity: 0.85 },
  puffinImageWrap: { width: 140, height: 140, marginBottom: 10 },
  puffinImage: { width: 140, height: 140 },
  motivation: {
    fontSize: fontSizes.sm,
    color: colors.gray600,
    textAlign: 'center',
    maxWidth: 260,
  },
  block: {
    backgroundColor: colors.gray200,
    borderRadius: 12,
    padding: 16,
    marginBottom: 20,
  },
  blockLabel: { fontSize: fontSizes.sm, color: colors.gray600, marginBottom: 8 },
  progressRow: { flexDirection: 'row', alignItems: 'baseline', gap: 6 },
  progressCurrent: { fontSize: 32, fontWeight: fontWeights.regular, color: colors.black },
  progressTotal: { fontSize: fontSizes.md, color: colors.gray600 },
  progressBarBg: {
    height: 2,
    backgroundColor: colors.gray400,
    marginTop: 10,
    borderRadius: 1,
    overflow: 'hidden',
  },
  progressBarFill: { height: '100%', backgroundColor: colors.black, borderRadius: 1 },
  section: { marginBottom: 24 },
  sectionTitle: {
    fontSize: fontSizes.md,
    fontWeight: fontWeights.semibold,
    color: colors.black,
    marginBottom: 12,
    paddingLeft: 4,
  },
  guidance: {
    borderLeftWidth: 2,
    borderLeftColor: colors.black,
    paddingLeft: 12,
    paddingVertical: 6,
    marginBottom: 12,
  },
  guidanceText: { fontSize: fontSizes.sm, color: colors.gray600, lineHeight: 20 },
  trainingCard: {
    backgroundColor: colors.gray200,
    borderRadius: 10,
    padding: 14,
    marginBottom: 10,
  },
  cardTitle: { fontSize: fontSizes.md, color: colors.black, marginBottom: 4 },
  cardSubtitle: { fontSize: fontSizes.xs, color: colors.gray600, marginBottom: 12 },
  metricsRow: { flexDirection: 'row', justifyContent: 'space-between', paddingHorizontal: 8 },
  metric: { alignItems: 'center' },
  metricValue: { fontSize: fontSizes.xl, fontWeight: fontWeights.regular, color: colors.black },
  metricUnit: { fontSize: fontSizes.xs, color: colors.gray600, marginTop: 2 },
  nutritionCard: {
    backgroundColor: colors.gray200,
    borderRadius: 10,
    paddingHorizontal: 16,
    paddingVertical: 8,
    marginBottom: 12,
  },
  nutritionRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray300,
  },
  nutritionRowLast: { borderBottomWidth: 0 },
  nutritionTitle: { fontSize: fontSizes.md, color: colors.black, marginBottom: 2 },
  nutritionSub: { fontSize: fontSizes.xs, color: colors.gray600 },
  nutritionValue: { fontSize: fontSizes.md, color: colors.black },
  caloriesRow: {
    flexDirection: 'row',
    alignItems: 'baseline',
    gap: 8,
  },
  caloriesLabel: { fontSize: fontSizes.sm, color: colors.gray600 },
  caloriesNum: { fontSize: fontSizes.lg, fontWeight: fontWeights.medium, color: colors.black },
  countdownOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  countdownBox: {
    backgroundColor: colors.white,
    borderRadius: 16,
    paddingVertical: 32,
    paddingHorizontal: 48,
    alignItems: 'center',
    minWidth: 120,
  },
  countdownNumber: {
    fontSize: 56,
    fontWeight: fontWeights.bold,
    color: colors.black,
  },
  countdownHint: {
    marginTop: 16,
    fontSize: fontSizes.sm,
    color: colors.gray600,
  },
});
