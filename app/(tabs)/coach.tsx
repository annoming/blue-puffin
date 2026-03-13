import { useState, useRef, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  Pressable,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  Image,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { colors, fontSizes, fontWeights } from '@/theme';

interface ChatMessage {
  id: string;
  role: 'user' | 'assistant';
  content: string;
}

const INITIAL_MESSAGES: ChatMessage[] = [
  {
    id: 'welcome',
    role: 'assistant',
    content: '你好！我是步凡的 AI 教练，可以问我训练计划、配速建议、恢复时间等问题～对话生成的方案会展示在首页。',
  },
];

/**
 * 教练页 - 仅对话；训练/营养/步态方案在首页展示
 */
export default function CoachScreen() {
  const [messages, setMessages] = useState<ChatMessage[]>(INITIAL_MESSAGES);
  const [inputText, setInputText] = useState('');
  const [isSending, setIsSending] = useState(false);
  const chatScrollRef = useRef<ScrollView>(null);
  const insets = useSafeAreaInsets();

  const scrollToBottom = () => {
    setTimeout(() => chatScrollRef.current?.scrollToEnd({ animated: true }), 100);
  };

  useEffect(() => {
    if (messages.length > 0) scrollToBottom();
  }, [messages.length]);

  const handleSend = async () => {
    const text = inputText.trim();
    if (!text || isSending) return;

    const userMsg: ChatMessage = { id: `user-${Date.now()}`, role: 'user', content: text };
    setMessages((prev) => [...prev, userMsg]);
    setInputText('');
    setIsSending(true);
    scrollToBottom();

    await new Promise((r) => setTimeout(r, 600));
    const assistantMsg: ChatMessage = {
      id: `assistant-${Date.now()}`,
      role: 'assistant',
      content: '收到你的问题啦～ AI 回复将在此显示，生成的训练/营养/步态方案会同步到首页。',
    };
    setMessages((prev) => [...prev, assistantMsg]);
    setIsSending(false);
    scrollToBottom();
  };

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      keyboardVerticalOffset={0}
    >
      {/* 顶部栏：仅标题 */}
      <View style={[styles.header, { paddingTop: insets.top + 12 }]}>
        <View style={styles.headerCenter}>
          <Text style={styles.pageTitle}>AI 教练</Text>
          <Text style={styles.pageSubtitle}>和教练聊聊</Text>
        </View>
      </View>

      <ScrollView
        ref={chatScrollRef}
        style={styles.chatScroll}
        contentContainerStyle={[styles.chatListContent, { paddingBottom: 16 }]}
        showsVerticalScrollIndicator={false}
        keyboardShouldPersistTaps="handled"
      >
        {messages.map((msg) => (
          <View
            key={msg.id}
            style={[
              styles.chatRow,
              msg.role === 'user' ? styles.chatRowUser : styles.chatRowAssistant,
            ]}
          >
            {msg.role === 'assistant' && (
              <Image
                source={require('../../assets/icon.png')}
                style={styles.avatar}
                resizeMode="cover"
              />
            )}
            <View
              style={[
                styles.bubble,
                msg.role === 'user' ? styles.bubbleUser : styles.bubbleAssistant,
              ]}
            >
              <Text
                style={[
                  styles.bubbleText,
                  msg.role === 'user' ? styles.bubbleTextUser : styles.bubbleTextAssistant,
                ]}
              >
                {msg.content}
              </Text>
            </View>
          </View>
        ))}
        {isSending && (
          <View style={[styles.chatRow, styles.chatRowAssistant]}>
            <Image
              source={require('../../assets/icon.png')}
              style={styles.avatar}
              resizeMode="cover"
            />
            <View style={[styles.bubble, styles.bubbleAssistant]}>
              <Text style={[styles.bubbleText, styles.bubbleTextAssistant]}>
                正在思考…
              </Text>
            </View>
          </View>
        )}
      </ScrollView>

      <View
        style={[
          styles.chatInputRow,
          { paddingBottom: Math.max(insets.bottom, 12) + 8 },
        ]}
      >
        <TextInput
          style={styles.chatInput}
          placeholder="输入问题，和教练聊聊…"
          placeholderTextColor={colors.gray400}
          value={inputText}
          onChangeText={setInputText}
          multiline
          maxLength={500}
          editable={!isSending}
          returnKeyType="send"
          onSubmitEditing={handleSend}
        />
        <Pressable
          onPress={handleSend}
          style={[
            styles.sendButton,
            (!inputText.trim() || isSending) && styles.sendButtonDisabled,
          ]}
          disabled={!inputText.trim() || isSending}
        >
          <Text
            style={[
              styles.sendButtonText,
              (!inputText.trim() || isSending) && styles.sendButtonTextDisabled,
            ]}
          >
            发送
          </Text>
        </Pressable>
      </View>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: colors.white },
  header: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 16,
    paddingBottom: 16,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray200,
  },
  headerCenter: { alignItems: 'center' },
  pageTitle: {
    fontSize: fontSizes.lg,
    color: colors.black,
    fontWeight: fontWeights.medium,
  },
  pageSubtitle: {
    fontSize: fontSizes.xs,
    color: colors.gray600,
    marginTop: 2,
  },
  chatScroll: { flex: 1 },
  chatListContent: { paddingHorizontal: 16, paddingTop: 16 },
  chatRow: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    marginBottom: 14,
  },
  chatRowUser: { justifyContent: 'flex-end' },
  chatRowAssistant: { justifyContent: 'flex-start', gap: 10 },
  avatar: { width: 36, height: 36, borderRadius: 18 },
  bubble: {
    maxWidth: '78%',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 18,
  },
  bubbleUser: {
    backgroundColor: colors.black,
    borderBottomRightRadius: 4,
  },
  bubbleAssistant: {
    backgroundColor: colors.gray200,
    borderBottomLeftRadius: 4,
  },
  bubbleText: { fontSize: fontSizes.sm, lineHeight: 22 },
  bubbleTextUser: { color: colors.white },
  bubbleTextAssistant: { color: colors.black },
  chatInputRow: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    paddingHorizontal: 16,
    paddingTop: 12,
    gap: 12,
    backgroundColor: colors.white,
    borderTopWidth: 1,
    borderTopColor: colors.gray200,
  },
  chatInput: {
    flex: 1,
    minHeight: 44,
    maxHeight: 100,
    paddingVertical: 12,
    paddingHorizontal: 16,
    fontSize: fontSizes.md,
    color: colors.black,
    backgroundColor: colors.gray200,
    borderRadius: 22,
  },
  sendButton: {
    paddingVertical: 12,
    paddingHorizontal: 20,
    justifyContent: 'center',
    backgroundColor: colors.black,
    borderRadius: 22,
  },
  sendButtonDisabled: { backgroundColor: colors.gray400 },
  sendButtonText: {
    fontSize: fontSizes.sm,
    fontWeight: fontWeights.semibold,
    color: colors.white,
  },
  sendButtonTextDisabled: { color: colors.gray200 },
});
