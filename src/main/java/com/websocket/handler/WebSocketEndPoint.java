package com.websocket.handler;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.springmvc.controller.BaseController;
import com.springmvc.model.Message;
import com.springmvc.model.User;
import com.springmvc.service.IMessageService;

import net.sf.json.JSONObject;

/**
 * websocket 服务端
 * 传递过来的消息均由 handleTextMessage 函数处理
 */
public class WebSocketEndPoint extends TextWebSocketHandler{
	
	private static Map<String, WebSocketSession> sessionList = new HashMap<String, WebSocketSession>();
	@SuppressWarnings("resource")
	private ApplicationContext context = new ClassPathXmlApplicationContext( 
			new String[]{"classpath:conf/spring.xml", "classpath:conf/spring-mybatis.xml"});
	private IMessageService messageService = (IMessageService) context.getBean("messageServiceImpl");
	
	/** 建立后将当前的websocket连接加入sessionList */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
	    Map<String, Object> sessionMap = session.getHandshakeAttributes();
	    if(sessionMap.containsKey("currentUser")){
	    	User user = (User) sessionMap.get("currentUser");
	    	int connect_id = user.getUser_id();
		   	sessionList.put("WEBSOCKET_USERID_"+connect_id, session);
	    }else{
	    	Throwable exception = new Throwable("====== 建立websocket连接时 session 传递参数有误======");
	    	super.handleTransportError(session, exception);
	    }
	}
	
	/** 处理客户端发送的消息 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		JSONObject jsonObject = this.getJSONObject(message.getPayload());
		String content = jsonObject.getString("content");
		int sender_id = Integer.parseInt(jsonObject.getString("sender_id"));
		int receiver_id = Integer.parseInt(jsonObject.getString("receiver_id"));
		String send_time = jsonObject.getString("send_time");
		
		Message save_message = new Message(content, send_time, sender_id, receiver_id);
	
		messageService.insertMessage(save_message);
		
        /** 服务器转发 message 至对应的 session 中 */
        WebSocketSession receive_session = sessionList.get("WEBSOCKET_USERID_"+receiver_id);
        if(receive_session != null)
        	receive_session.sendMessage(message);
    }  
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    super.afterConnectionClosed(session, status);
	    removeWebsocketConnection(session);
	}
	
	/** 错误处理，直接从sessionList中移除该websocket连接 */
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	    super.handleTransportError(session, exception);
	    removeWebsocketConnection(session);
	}
	
	/** 解析json格式字符串，存为json对象 JSONObject */
	protected JSONObject getJSONObject(Object jsonData) throws Exception{
		/** 解码，为了解决中文乱码 */
		String str = URLDecoder.decode(jsonData.toString(), "UTF-8");
		
		return JSONObject.fromObject(str);
	}
	
	/** 从sessionList中移除已关闭的 websocket 连接 */
	protected void removeWebsocketConnection(WebSocketSession session){
		if (session.isOpen()){
	    	Map<String, Object> sessionMap = session.getHandshakeAttributes();
		    if(sessionMap.containsKey("currentUser")){
		    	User user = (User) sessionMap.get("currentUser");
		    	int connect_id = user.getUser_id();
		    	sessionList.remove("WEBSOCKET_USERID_"+connect_id);
		    }
	    }
	}
}
