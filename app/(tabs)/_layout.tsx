import { Tabs } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { colors } from '@/theme';

/** 与 Puffinfigma 对应：Home, Brain, Users, UserCircle */
const tabIcons: Record<string, { active: string; inactive: string }> = {
  index: { active: 'home', inactive: 'home-outline' },
  coach: { active: 'bulb', inactive: 'bulb-outline' },
  community: { active: 'people', inactive: 'people-outline' },
  profile: { active: 'person-circle', inactive: 'person-circle-outline' },
};

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={({ route }) => {
        const icons = tabIcons[route.name as keyof typeof tabIcons];
        return {
          tabBarActiveTintColor: colors.black,
          tabBarInactiveTintColor: colors.gray600,
          tabBarIcon: ({ focused, color, size }) => {
            if (!icons) return null;
            const name = focused ? icons.active : icons.inactive;
            return <Ionicons name={name} size={size ?? 22} color={color} />;
          },
          tabBarStyle: {
            backgroundColor: colors.white,
            borderTopWidth: 1,
            borderTopColor: colors.gray200,
          },
          tabBarLabelStyle: { fontSize: 12 },
          headerStyle: { backgroundColor: colors.white },
          headerTintColor: colors.black,
          headerTitleStyle: { fontWeight: '500', fontSize: 18 },
          headerShadowVisible: false,
        };
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: '陪跑舱',
          tabBarLabel: '陪跑舱',
          headerShown: false,
        }}
      />
      <Tabs.Screen
        name="coach"
        options={{
          title: 'AI 教练',
          tabBarLabel: '教练',
          headerShown: false,
        }}
      />
      <Tabs.Screen
        name="community"
        options={{
          title: '跑圈',
          tabBarLabel: '跑圈',
        }}
      />
      <Tabs.Screen
        name="profile"
        options={{
          title: '我的',
          tabBarLabel: '我的',
          headerShown: false,
        }}
      />
      <Tabs.Screen
        name="run"
        options={{ href: null }}
      />
      <Tabs.Screen
        name="achievements"
        options={{ href: null }}
      />
    </Tabs>
  );
}
