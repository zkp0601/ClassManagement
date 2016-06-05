package com.springmvc.controller;

import java.io.FileOutputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.model.User_infos;
import com.springmvc.service.IUser_infosService;

import sun.misc.BASE64Decoder;

@Controller
@RequestMapping(value={"/img"})
public class ImgController extends BaseController{
	@RequestMapping(value={"/decode"})
	@ResponseBody
	public String generateImage(HttpServletRequest request){
		
		String imgBase64Str = request.getParameter("imgBase64Str");
		if(imgBase64Str == null)
			return "";
		
		/** 对传入的Base64位编码字符串进行处理，去掉data:image/jpeg;base64,这个前缀后才能转为图片 */
		int pos = imgBase64Str.indexOf(",");
		String imgType = imgBase64Str.substring(11, pos-7); //获取当前参数中的图片格式
		imgBase64Str = imgBase64Str.substring(pos+1);
		
		BASE64Decoder decoder = new BASE64Decoder();
		try{
			byte[] b = decoder.decodeBuffer(imgBase64Str);
			for(int i = 0; i < b.length; i++){
				/** 调整异常数据 */
				if(b[i] < 0) 
					b[i] += 256; 
			}
			/** 设置上传图片的存储路径及命名 */
			String webRoot = request.getServletContext().getRealPath("/");
			User_infos user_info = (User_infos) request.getSession().getAttribute("currentUser_info");
			String filename = "_"+user_info.getUser_id();
			String imgFilePath = webRoot + "img/user_uploads/" + filename + "." + imgType;
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(b);
			out.flush();
			out.close();

			/** 更新个人信息 */
			String img_url = "/img/user_uploads/" + filename + "." + imgType;
			user_info.setImg_url(img_url);
			IUser_infosService user_infosService = (IUser_infosService) this.context.getBean("user_infosServiceImpl");
			user_infosService.updateUser_infosByID(user_info);
			request.getSession().setAttribute("currentUser_info", user_info);
			return "/ClassManagement"+img_url;
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
		
	}
}
