package board.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadUtil {
	
	public HashMap<String, String> uploadFile(HttpServletRequest request){
		HashMap<String, String> dataMap = new HashMap<String, String>();
		
		//request에 upload 요청이 있는지 확인
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if(isMultipart){
			
			// 전송된 파일을 디스크에 저장하기 위한 객체
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);

			// Parse the request
			List<FileItem> items = null;
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e1) {				
				e1.printStackTrace();
			}			
			
			//폼 or 파일 데이터인지 구분
			String fieldName = "", fileName="", value="";
			Iterator<FileItem> iter = items.iterator();
			while (iter.hasNext()) {
			    FileItem item = iter.next();
			
			    if (item.isFormField()) { // type=text, password, email....
			        fieldName = item.getFieldName();
			    	try {
						value = item.getString("utf-8");  // 사용자 입력값
						
						dataMap.put(fieldName, value);
					} catch (UnsupportedEncodingException e) {						
						e.printStackTrace();
					}
			    	
			    } else {
			    	fieldName = item.getFieldName();
			    	fileName = item.getName(); 		
			    	
			    	
			    	//서버에 파일저장
			    	//동일한 파일명이 들어올 경우 => 중복되지 않은 고유의 값을 파일명에 추가
			    	if(!fileName.isEmpty() && item.getSize() > 0){
			    		String path = "e:\\upload";
			    		
			    		UUID uuid = UUID.randomUUID();
			    		
			    		File uploadFile = new File(path+"\\"+uuid.toString()+"_"+fileName);
			    		
			    		
			    		dataMap.put(fieldName, uploadFile.getName());
			    		
			    		try {
							item.write(uploadFile);
						} catch (Exception e) {							
							e.printStackTrace();
						}	    		
			    		
			    	}
			    	
			    }
			}		
		}
		
		return dataMap;
	}
}