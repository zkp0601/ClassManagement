package com.springmvc.model;

public class Message {
	private int message_id = 0;
	private String content;
	private String send_time;
	private int sender_id;
	private int receiver_id;
	private int is_read = 0;
	
	public Message(){
		
	}
	
	public Message(String content, String send_time, int sender_id, int receiver_id){
		this.content = content;
		this.send_time = send_time;
		this.sender_id = sender_id;
		this.receiver_id = receiver_id;
	}

	public int getMessage_id() {
		return message_id;
	}

	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSend_time() {
		return send_time;
	}

	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}

	public int getSender_id() {
		return sender_id;
	}

	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}

	public int getReceiver_id() {
		return receiver_id;
	}

	public void setReceiver_id(int receiver_id) {
		this.receiver_id = receiver_id;
	}

	public int getIs_read() {
		return is_read;
	}

	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}
}
