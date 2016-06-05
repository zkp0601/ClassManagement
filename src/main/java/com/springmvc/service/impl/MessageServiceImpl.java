package com.springmvc.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;

import com.springmvc.dao.IMessageDAO;
import com.springmvc.model.Message;
import com.springmvc.service.IMessageService;

@Service
@Configuration
public class MessageServiceImpl implements IMessageService{
	
	@Autowired
	private IMessageDAO messageDAO;
	
	public void insertMessage(Message message){
		messageDAO.insertMessage(message);
	}
	
	public List<Message> selectMessagesBySenderAndReceiverId(int sender_id, int receiver_id){
		return messageDAO.selectMessagesBySenderAndReceiverId(sender_id, receiver_id);
	}
	
	public List<Message> selectMessagesByIs_read(int receiver_id, int is_read){
		return messageDAO.selectMessagesByIs_read(receiver_id, is_read);
	}
	
	/** 将两者聊天信息设为已读 */
	public void updateUnreadMessage(int sender_id, int receiver_id){
		messageDAO.updateUnreadMessage(sender_id, receiver_id);
	}
}
