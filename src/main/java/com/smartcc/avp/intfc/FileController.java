package com.smartcc.avp.intfc;

import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.file.FileUtil;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/api")
public class FileController {
    private static final Logger logger = LoggerFactory.getLogger(InterfaceController.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
    private static final SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMM");

    String ym = DateUtil.getMonth();
    String ymd = DateUtil.getDay();

    @Autowired
    FileService fileService;

    @RequestMapping(value="/filelist",method = { RequestMethod.GET})
    @ResponseBody
    public Response file_download(HttpServletRequest request, HttpServletResponse response) throws Exception {


        List<FileData> filelist = fileService.getFileList();

        return new Response(filelist);
    }

    @RequestMapping(value="/filedownload",method = { RequestMethod.GET})
    @ResponseBody
    public ResponseEntity file_download(@RequestParam("fileSavePath") String fileSavePath) throws IOException {
        String filePath = fileSavePath;
        ResponseEntity result = FileUtil.fileDownload(filePath);
        return result;
    }
}
