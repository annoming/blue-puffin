import { Tabs } from 'expo-router';
import { colors } from '@/theme';

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.gray600,
        headerStyle: { backgroundColor: colors.primary },
        headerTintColor: colors.white,
        headerTitleStyle: { fontWeight: '600', fontSize: 18 },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: '步凡',
          tabBarLabel: '首页',
        }}
      />
      <Tabs.Screen
        name="run"
        options={{
          title: '开始跑步',
          tabBarLabel: '跑步',
        }}
      />
      <Tabs.Screen
        name="achievements"
        options={{
          title: '成就',
          tabBarLabel: '成就',
        }}
      />
      <Tabs.Screen
        name="profile"
        options={{
          title: '我的',
          tabBarLabel: '我的',
        }}
      />
    </Tabs>
  );
}
