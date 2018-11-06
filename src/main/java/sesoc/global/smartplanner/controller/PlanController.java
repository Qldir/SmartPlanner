package sesoc.global.smartplanner.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import sesoc.global.smartplanner.dao.PlanRepository;
import sesoc.global.smartplanner.dto.PlacePageVO;
import sesoc.global.smartplanner.dto.PlaceTypeVO;
import sesoc.global.smartplanner.dto.PlaceVO;
import sesoc.global.smartplanner.dto.PlanPageDTO;
import sesoc.global.smartplanner.dto.PlanDayDTO;
import sesoc.global.smartplanner.dto.PlanVO;
import sesoc.global.smartplanner.dto.RouteInfoDTO;
import sesoc.global.smartplanner.util.PageNavigator;
import sesoc.global.smartplanner.util.RouteSearcher;
import sesoc.global.smartplanner.util.ScheduleGenerator;
import sesoc.global.smartplanner.util.ThemeScheduleGenerator;

@Controller
public class PlanController {

	@Autowired
	ScheduleGenerator generator;
	@Autowired
	ThemeScheduleGenerator themeGenerator;
	@Autowired
	PlanRepository planRepository;

	@RequestMapping(value = "/planbyoption", method = RequestMethod.POST)
	public String createPlan(Model model, PlanVO plan, PlaceTypeVO placeType) throws ParseException {

		plan.setPlan_area(placeType.getPlace_area());
		System.out.println(plan);
		System.out.println(placeType);

		ArrayList<PlanDayDTO> resultList = generator.generate(plan, placeType);

		PlanPageDTO dto = new PlanPageDTO();
		dto.setPlan(plan);
		dto.setDayPlanList(resultList);

		System.out.println(dto);

		Gson gson = new Gson();
		String result = gson.toJson(dto);

		model.addAttribute("result", result);

		return "planresult";
	}

	@RequestMapping(value = "/planbytheme", method = RequestMethod.POST)
	public String planningByTheme(Model model, PlanVO plan, int plan_theme) {
		System.out.println(plan);
		System.out.println(plan_theme);
		ArrayList<PlanDayDTO> resultList = themeGenerator.generate(plan, plan_theme);

		PlanPageDTO dto = new PlanPageDTO();
		dto.setPlan(plan);
		dto.setDayPlanList(resultList);

		Gson gson = new Gson();
		String result = gson.toJson(dto);

		model.addAttribute("result", result);
		return "planresult";
	}
	
	@RequestMapping(value = "/planbyselect", method = RequestMethod.POST)
	public String placesearchbeforeAjax(Model model, PlanVO plan) {
		
		Gson gson = new Gson();
		String result = gson.toJson(plan);

		model.addAttribute("result", result);
		
		return "planbyselect";
	}
	

	@RequestMapping(value = "/insertplan", method = RequestMethod.POST)
	public @ResponseBody int insertPlan(@RequestBody PlanPageDTO dto, HttpSession httpSession) {

		dto.getPlan().setMember_seq((String) httpSession.getAttribute("member_seq"));

		int result = planRepository.insert(dto);

		return result;
	}

	@RequestMapping(value = "/detailplan", method = RequestMethod.GET)
	public String detailPlan(String num, HttpSession httpSession, Model model) {

		PlanVO plan = new PlanVO();
		plan.setPlan_seq(num);
		String member_seq = (String) httpSession.getAttribute("member_seq");
		plan.setMember_seq(member_seq);

		if (member_seq == null)
			return null;

		PlanPageDTO dto = planRepository.getPlan(plan);

		if (dto == null)
			return null;

		Gson gson = new Gson();
		String result = gson.toJson(dto);

		model.addAttribute("result", result);
		return "plandetail";
	}

	@RequestMapping(value = "/updateplan", method = RequestMethod.POST)
	public String updatePlan(String plan_seq, HttpSession httpSession, Model model) {

		PlanVO plan = new PlanVO();
		plan.setPlan_seq(plan_seq);
		String member_seq = (String) httpSession.getAttribute("member_seq");
		plan.setMember_seq(member_seq);

		if (member_seq == null)
			return null;

		PlanPageDTO dto = planRepository.getPlan(plan);

		if (dto == null)
			return null;

		Gson gson = new Gson();
		String result = gson.toJson(dto);

		model.addAttribute("result", result);
		return "planupdate";
	}
	
	@RequestMapping(value ="/updateplanaction", method = RequestMethod.POST)
	public @ResponseBody int updatePlanAction(@RequestBody PlanPageDTO dto){
		int result = planRepository.update(dto);
		return result;
	}

	@RequestMapping(value = "/deleteplan", method = RequestMethod.POST)
	public String deletePlan(PlanVO plan, HttpSession httpSession) {
		plan.setMember_seq((String) httpSession.getAttribute("member_seq"));
		int result = planRepository.delete(plan);
		if (result == 1) {
			return "redirect:/myplan";
		} else {
			return null;
		}
	}
	
	@RequestMapping(value ="/searchroute", method = RequestMethod.POST)
	public @ResponseBody RouteInfoDTO searchRoute(String addressList){
		System.out.println(addressList);
		
		JsonArray object=new JsonParser().parse(addressList).getAsJsonArray();
		
		ArrayList<PlaceVO> placeList=new ArrayList<PlaceVO>();
		for(int i=0;i<object.size();i++) {
			PlaceVO vo=new PlaceVO();
			vo.setPlace_location(object.get(i).getAsJsonPrimitive().getAsString());
			vo.setPlace_name("");
			placeList.add(vo);
		}
		
		RouteSearcher routeSearcher = new RouteSearcher();
		ArrayList<RouteInfoDTO> resultList=routeSearcher.calRoutes(placeList, 0);
	
		return resultList.get(0);
	}
	
	@RequestMapping(value = "/planprint", method = RequestMethod.GET)
	public String printPlan(String num, HttpSession httpSession, Model model) {

		PlanVO plan = new PlanVO();
		plan.setPlan_seq(num);

		PlanPageDTO dto = planRepository.getPlan(plan);

		if (dto == null)
			return null;

		Gson gson = new Gson();
		String result = gson.toJson(dto);

		model.addAttribute("result", result);
		return "planprint";
	}

	@RequestMapping(value = "/searchmap", method = RequestMethod.GET)
	public void searchMap() {
	}
}
