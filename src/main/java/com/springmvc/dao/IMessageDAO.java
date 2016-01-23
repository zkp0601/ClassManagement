package com.springmvc.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.springmvc.model.Message;

public interface IMessageDAO {
	/**
	 * 插入一条新的聊天信息
	 **/
	public void insertMessage(Message message);
	
	/** 获取两者之间的多条聊天信息 */
	public List<Message> selectMessagesBySenderAndReceiverId(@Param("sender_id")int sender_id, @Param("receiver_id")int receiver_id);
	
	/** 通过信息状态查询两者间的聊天信息 */
	public List<Message> selectMessagesByIs_read(@Param("receiver_id") int receiver_id, @Param("is_read") int is_read);
	
	/** 将两者聊天信息设为已读 */
	public void updateUnreadMessage(@Param("sender_id")int sender_id, @Param("receiver_id") int receiver_id);
}
