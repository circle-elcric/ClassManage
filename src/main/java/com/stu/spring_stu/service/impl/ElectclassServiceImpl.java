package com.stu.spring_stu.service.impl;

import com.stu.spring_stu.entity.Electclass;
import com.stu.spring_stu.mapper.ElectclassMapper;
import com.stu.spring_stu.service.IElectclassService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 选课表 服务实现类
 * </p>
 *
 * @author ybh
 * @since 2022-05-17
 */
@Service
public class ElectclassServiceImpl extends ServiceImpl<ElectclassMapper, Electclass> implements IElectclassService {

    @Autowired
    private ElectclassMapper electclassMapper;

    @Transactional
    @Override
    public Electclass selectcourse(String stuId, String couId, String teaId) {
        electclassMapper.delcourse(stuId, couId, teaId);
        electclassMapper.selectcourse(stuId, couId, teaId);
        Electclass electclass = new Electclass();
        return  electclass;
    }
}
