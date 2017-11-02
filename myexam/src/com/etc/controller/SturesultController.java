package com.etc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.etc.entity.Paper;
import com.etc.entity.Students;
import com.etc.entity.Sturesult;
import com.etc.entity.Tpaper;
import com.etc.service.ISturesultService;
import com.etc.util.PageData;

/**
 * 成绩表的控制器
 * @author 丁佳丽
 * @version 2.0
 * @create date 2017年6月16日10:26:04
 *
 */
@Controller
@RequestMapping(value="Sturesult")
public class SturesultController {
	//注入SturesultService
	@Resource
	private ISturesultService SturesultService;
	/**
	 * 成绩分页显示	面向管理员
	 * @param pb
	 * @return
	 */
	@RequestMapping(value = "show", method = RequestMethod.GET)
	@ResponseBody  //返回的是json对象
	public Map queryAllByPage(Integer page, Integer rows) {
		
		Map map = new HashMap();
		PageData<Sturesult> pd = SturesultService.showByPage(page,rows);  //1 rows其实就是pageBean中的那个pagesize
		System.out.println(pd);
		map.put("rows", pd.getData());
		map.put("total", pd.getTotal());
		System.out.println(map);
		return map;
	}
	/**
	 * 成绩分页显示	面向学生
	 * @param pb
	 * @return
	 */
	@RequestMapping(value = "showForStu", method = RequestMethod.GET)	
	public ModelAndView queryAllByPage(HttpServletRequest request) {
		ModelAndView mol = new ModelAndView();
		Students stu = (Students) request.getSession().getAttribute("stu");
		if(stu!=null){
			int stuid=stu.getStuid();
			Map map = new HashMap();
			Students list= SturesultService.showByPageForStu(stuid);
		/*	map.put("stu", list);*/
						mol.addObject("list", list);
			mol.setViewName("student/result");
			System.out.println("student============================================================="+list);
			return mol;
		}
		else {
			mol.setViewName("student/result");
			return mol;
		}		
	}
	/**
	 * 考卷的显示   面向管理员
	 * @param tpaperid
	 * @return
	 */
	@RequestMapping(value="showpaper/{tpaperid}",method=RequestMethod.GET)
	public ModelAndView showPaper(@PathVariable(value="tpaperid")int tpaperid)
	{
		//查询试题的数量
		int x=SturesultService.countType1(1,tpaperid);
		int y=SturesultService.countType1(2,tpaperid);
		int z=SturesultService.countType1(3,tpaperid);
		
		System.out.println("单选题数:"+x);
		
		Tpaper tpaper= SturesultService.showPaper(tpaperid);
		//学生答案的拼接
		String ans= tpaper.getBackups().getAnswers();
		//学生答案的数组
		String[] arr=ans.split("[+]");
		//获得试卷信息表集合
		List<Paper>  list = tpaper.getPapers();
		for (int i = 0; i < arr.length; i++) {
			//将集合试卷信息表遍历取出
			Paper p = list.get(i);
			//anw是单题的答案
			p.setAws(arr[i]);
			//将单题答案存放进试卷信息集合中
			list.set(i, p);
		}
		
		System.out.println(tpaper.toString());
		ModelAndView mv=new ModelAndView();
		mv.addObject("tpaper", tpaper);
		mv.addObject("x", x); 
		mv.addObject("y", y); 	
		mv.addObject("z",z);
		mv.addObject("list", list);
		mv.setViewName("student/ShowPaper");
		
		return mv;	
	}
	
	
	
	/**
	 * 考卷的显示   面向学生
	 * @param tpaperid
	 * @return
	 */
	@RequestMapping(value="showpaperforstu/{tpaperid}",method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView showPaperForStu(@PathVariable(value="tpaperid")int tpaperid)
	{
		//查询试题的数量
		int x=SturesultService.countType1(1,tpaperid);
		int y=SturesultService.countType1(2,tpaperid);
		int z=SturesultService.countType1(3,tpaperid);
		Tpaper tpaper= SturesultService.showPaper(tpaperid);
		//学生答案的拼接
		String ans= tpaper.getBackups().getAnswers();
		//学生答案的数组
		String[] arr=ans.split("[+]");
		//获得试卷信息表集合
		List<Paper>  list = tpaper.getPapers();
		for (int i = 0; i < arr.length; i++) {
			//将集合试卷信息表遍历取出
			Paper p = list.get(i);
			//anw是单题的答案
			p.setAws(arr[i]);
			//将单题答案存放进试卷信息集合中
			list.set(i, p);
		}
		
		System.out.println(tpaper.toString());
		ModelAndView mv=new ModelAndView();
		mv.addObject("tpaper", tpaper);
		mv.addObject("x", x); 
		mv.addObject("y", y); 	
		mv.addObject("z",z);
		mv.addObject("list", list);
		mv.setViewName("student/ShowPaperForStu");
		
		return mv;	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
