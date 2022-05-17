package com.stu.spring_stu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.stu.spring_stu.entity.Department;
import org.apache.logging.log4j.util.Strings;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

import com.stu.spring_stu.service.IElectclassService;
import com.stu.spring_stu.entity.Electclass;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 选课表 前端控制器
 * </p>
 *
 * @author ybh
 * @since 2022-05-17
 */
@RestController
@RequestMapping("/electclass")
public class ElectclassController {

    @Resource
    private IElectclassService electclassService;


    @PostMapping
    public boolean save(@RequestBody Electclass electclass){
        return electclassService.saveOrUpdate(electclass);
    }

    @GetMapping
    public List<Electclass> findAll() {
        return electclassService.list();
    }

    @DeleteMapping("/{id}")
    public Boolean delete(@PathVariable Integer id){
        return electclassService.removeById(id);
    }

    @GetMapping("/{id}")
    public Electclass findOne(@PathVariable Integer id) {
        return electclassService.getById(id);
    }

    @PostMapping("/del/batch")
    public boolean deleteBatch(@RequestBody List<Integer> ids) { // [1,2,3]
        return electclassService.removeByIds(ids);
    }

    @GetMapping("/page")
    public Page<Electclass> findPage(@RequestParam Integer pageNum,
                                     @RequestParam Integer pageSize,
                                     @RequestParam(defaultValue = "") String stuId,
                                     @RequestParam(defaultValue = "") String couId,
                                     @RequestParam(defaultValue = "") String teaId) {
        QueryWrapper<Electclass> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(Strings.isNotEmpty(stuId),"stu_id",stuId);
        queryWrapper.like(Strings.isNotEmpty(couId),"cou_id",couId);
        queryWrapper.like(Strings.isNotEmpty(teaId),"tea_id",teaId);
        return electclassService.page(new Page<>(pageNum, pageSize),queryWrapper);
    }

}
