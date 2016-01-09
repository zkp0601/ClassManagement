package com.springmvc.service;

import java.util.List;
import java.util.Map;

import com.springmvc.model.Message;

public interface IMessageService {
	/**
	 * 插入一条新的聊天信息
	 **/
	public void insertMessage(Message message);
	
	/** 获取两者之间的多条聊天信息 */
	public List<Message> selectMessagesBySenderAndReceiverId(int sender_id, int receiver_id);
	
	/** 通过信息状态查询两者间的聊天信息 */
	public List<Message> selectMessagesByIs_read(int sender_id, int receiver_id, int is_read);
}
