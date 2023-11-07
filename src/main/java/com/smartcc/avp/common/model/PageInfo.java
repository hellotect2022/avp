package com.smartcc.avp.common.model;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.bind.MethodArgumentNotValidException;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.smartcc.avp.common.model.reauest.BaseRequest;

import lombok.Data;

@Data
public class PageInfo implements BaseRequest {
	private Integer page;
	@NotEmpty
	private Integer size;
	private Integer resultCount;
	
	private Integer totalCount;
	@JsonIgnore
	private Integer startRowNum;
	
	private Integer pageBlock = 10;
	
	public PageInfo() {}
	
	public PageInfo(int page, int size) {
		this.page = page;
		this.size = size;
	}
	
	public PageInfo(int page, int size, int resultCount, int totalCount) {
		this.page = page;
		this.size = size;
		this.resultCount = resultCount;
		this.totalCount = totalCount;
	}
	
	
	/*for paging*/
	public Integer getStartRowNum()
	{
		// page 가  null 이면 1을 리턴 
		// db에서는  limit 1(startRowNum), 10 을 가져오게 된다 
		if(page == null)
		{
			page = 1;
		}
		
		// page 가  null이 아니면 
		// 선택한 페이지 번호가 1이면 : (1-1)*10 = 0 -> limit 0, 10
		// 선택한 페이지 번호가 2이면 : (2-1)*10 = 10 -> limit 10,10 으로 계산됨
		// db에서는  limit 1(startRowNum), 10 을 가져오게 된다 
		return ((page-1)*size);
	}
	public Integer getBlockFirstPage(){
		int blockFirstPage = ((page-1) / 10 * 10 ) +1;
		
		
		// ((1-1) / 10 * 10 ) +1 = 1;
		// ((2-1) / 10 * 10 ) +1 = 2;
		System.out.println("(page-1) : " + (page-1));
		System.out.println("((page-1) / 10 ) : " + ((page-1) / 10 ));
		System.out.println("((page-1) / 10 * 10 ) : " + ((page-1) / 10 * 10 ));
		System.out.println("blockFirstPage : " + blockFirstPage);
		return blockFirstPage;
		 
	}
	public Integer getBlockLastPage(){
		int blockLastPage =  ((page-1) / 10 * 10 ) +pageBlock;
		return 	getLastPage() < blockLastPage ? getLastPage() : blockLastPage;
	}
	
	public Integer getLastPage()
	{
		return ((totalCount-1)/size)+1;
	}

	@Override
	public void validate() throws MethodArgumentNotValidException, ApiException {
		// TODO Auto-generated method stub
		
	}
}
