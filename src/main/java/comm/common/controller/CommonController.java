package comm.common.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import comm.common.common.CommandMap;
import comm.common.service.CommonService;

@Controller
public class CommonController {
	Logger log = Logger.getLogger(this.getClass());
	private static final String tempFilePath = "C:\\comm\\tempImages\\";
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	@RequestMapping(value="/common/downloadFile.do")
	public void downloadFile(CommandMap commandMap, HttpServletResponse response) throws Exception{
		Map<String,Object> map = commonService.selectFileInfo(commandMap.getMap());
		String storedFileName = (String)map.get("STORED_FILE_NAME");
		String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File("C:\\dev\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@RequestMapping(value="/common/GetTempFile.do")
	public void getTempFile(CommandMap commandMap, HttpServletResponse response) throws Exception{
		Map<String,Object> map = commandMap.getMap();
		String storedFileName = (String)map.get("filename");
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(tempFilePath+storedFileName));
		
		response.setContentType("image/jpeg");
		response.setContentLength(fileByte.length);
		response.getOutputStream().write(fileByte);
		
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@RequestMapping(value="/common/GetTempFileUrl.do")
	public void getTempFileUrl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String resultUrl = comm.common.util.FileUtils.getTempFileUrl(request);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		out.print(resultUrl);
		System.out.println(resultUrl);
	}
}
