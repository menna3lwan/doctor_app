import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';

class ChatScreen extends StatefulWidget {
  final String appointmentId;
  const ChatScreen({super.key, required this.appointmentId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<_Message> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages.addAll([
      _Message(text: 'مرحباً دكتورة، أنا قلقانة من بعض الأعراض', isMe: false, time: '10:00 ص'),
      _Message(text: 'أهلاً بك، لا تقلقي. اشرحي لي الأعراض بالتفصيل', isMe: true, time: '10:01 ص'),
      _Message(text: 'عندي ألم في منطقة البطن من أسبوع تقريباً', isMe: false, time: '10:02 ص'),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(_Message(
        text: _messageController.text,
        isMe: true,
        time: TimeOfDay.now().format(context),
      ));
      _messageController.clear();
    });
    
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // Simulate patient typing
    setState(() => _isTyping = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(_Message(text: 'شكراً دكتورة على الاهتمام', isMe: false, time: TimeOfDay.now().format(context)));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final appointment = context.watch<AppointmentsProvider>().getAppointmentById(widget.appointmentId);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryLight,
              child: Text(appointment?.patient.name[0] ?? 'م', style: const TextStyle(color: AppColors.primary)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appointment?.patient.name ?? '', style: const TextStyle(fontSize: 14)),
                  Text(locale.get('sessionActive'), style: const TextStyle(fontSize: 11, color: AppColors.success)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () => _showOptions(context, locale)),
        ],
      ),
      body: Column(
        children: [
          // Session Info Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: AppColors.primaryLight.withOpacity(0.3),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(child: Text('${locale.get('online')} - ${appointment?.time ?? ''}', style: const TextStyle(fontSize: 12))),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
                      child: Text(locale.get('patientTyping'), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ),
                  );
                }
                final msg = _messages[index];
                return _MessageBubble(message: msg);
              },
            ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.attach_file), onPressed: () => _showAttachOptions(context)),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: locale.get('typeMessage'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 20), onPressed: _sendMessage),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, LocaleProvider locale) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.primary),
              title: Text(locale.get('medicalHistory')),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.note_add, color: AppColors.primary),
              title: const Text('إضافة ملاحظات'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle, color: AppColors.success),
              title: Text(locale.get('endConsultation')),
              onTap: () {
                Navigator.pop(context);
                _showEndDialog(context, locale);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEndDialog(BuildContext context, LocaleProvider locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.get('endConsultation')),
        content: const Text('هل أنت متأكدة من إنهاء الاستشارة؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(locale.get('cancel'))),
          ElevatedButton(
            onPressed: () {
              context.read<AppointmentsProvider>().completeAppointment(widget.appointmentId);
              Navigator.pop(context);
              context.go('/dashboard');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.success));
            },
            child: const Text('إنهاء'),
          ),
        ],
      ),
    );
  }

  void _showAttachOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _AttachOption(icon: Icons.image, label: 'صورة', color: Colors.purple, onTap: () => Navigator.pop(context)),
            _AttachOption(icon: Icons.camera_alt, label: 'كاميرا', color: Colors.pink, onTap: () => Navigator.pop(context)),
            _AttachOption(icon: Icons.insert_drive_file, label: 'ملف', color: Colors.blue, onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _Message {
  final String text;
  final bool isMe;
  final String time;
  _Message({required this.text, required this.isMe, required this.time});
}

class _MessageBubble extends StatelessWidget {
  final _Message message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text, style: TextStyle(color: message.isMe ? Colors.white : Colors.black)),
            const SizedBox(height: 4),
            Text(message.time, style: TextStyle(fontSize: 10, color: message.isMe ? Colors.white70 : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _AttachOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _AttachOption({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 28, backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
