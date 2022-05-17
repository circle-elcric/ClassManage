package com.stu.spring_stu.mapper;

import com.stu.spring_stu.entity.Course;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 课程表 Mapper 接口
 * </p>
 *
 * @author ybh
 * @since 2022-05-17
 */
@Mapper
public interface CourseMapper extends BaseMapper<Course> {

}
