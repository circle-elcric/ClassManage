<template>
  <div>
    <div style="margin-bottom: 30px">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/t' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>选课表管理</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入学号" suffix-icon="el-icon-message" class="ml-5" v-model="stuId"></el-input>
      <el-input style="width: 200px" placeholder="请输入课程号" suffix-icon="el-icon-message" class="ml-5" v-model="couId"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">清空</el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" @selection-change="handleSelectionChange">
      <el-table-column prop="stuId" label="学号" width="120">
      </el-table-column>
      <el-table-column prop="name" label="学生" width="140">
      </el-table-column>
      <el-table-column prop="couId" label="课程号" width="120">
      </el-table-column>
      <el-table-column prop="cname" label="课程名" width="140">
      </el-table-column>
      <el-table-column prop="xq" label="开课学期" width="120">
      </el-table-column>
      <el-table-column prop="time" label="开课时间" width="120">
      </el-table-column>
      <el-table-column prop="cj" label="成绩" width="120">
      </el-table-column>
      <el-table-column prop="point" label="绩点">
      </el-table-column>
      <el-table-column label="操作"  width="240" align="center">
        <template slot-scope="scope">
          <el-button type="primary" v-if="scope.row.cj == null" @click="Edit(scope.row)">登分<i class="el-icon-edit"></i></el-button>
          <el-button type="danger" v-if="scope.row.cj != null" @click="Edit(scope.row)">改分<i class="el-icon-edit"></i></el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 4, 6, 8, 10]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>


    <el-dialog title="修改分数" :visible.sync="dialogFormVisible" width="30%">
      <el-form :model="form"
               ref="form"
               :rules="rules"
      >
        <el-form-item
            prop="cj"
            label="成绩"
            :label-width="formLabelWidth">
          <el-input v-model.number="form.cj"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="gradesave('form')">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Course",
  data() {
    var checkGrade = (rule, value, callback) => {
      console.log(value)
      if (!value) {
        return callback(new Error('成绩不能为空'));
      }
      setTimeout(() => {
        if (!Number.isInteger(value)) {
          callback(new Error('请输入数字值'));
        } else {
          if (value < 0 || value > 100) {
            callback(new Error('分数必须在0-100之间'));
          } else {
            callback();
          }
        }
      }, 1000);
    };
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      stuId: "",
      name:"",
      teaId: "",
      couId: "",
      cname:"",
      xq:"",  //课程学期
      time:"",  //课程时间
      cj: "",  //成绩
      point: "",  //成绩
      multipleSelection: [],
      dialogFormVisible: false,
      form: {
        cj:''
      },
      formLabelWidth: "80px",
      user:localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")):{},
      radio:localStorage.getItem("radio")?JSON.parse(localStorage.getItem("radio")):{},
      rules:{
        cj:[
          { validator: checkGrade, trigger: 'blur' }
            ]
      }
    }
  },
  created() {
    this.load()
  },
  methods:{
    load(){
      this.request.get("http://localhost:9090/electclass/page",{
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          stuId: this.stuId,
          couId: this.couId,
          teaId: this.user.teaId,
        }
      }).then(res =>{
        console.log(res)
        console.log(this.user)
        this.tableData = res.records
        this.total = res.total
      })
    },
    reset(){ //重置搜索框
      this.stuId = ""
      this.couId = ""
      this.load()
    },
    Edit(row){
      this.form = Object.assign({},row)  //该方法相比下一行，会使得修改数据的时候不会立刻刷新页面
      //this.form = row
      this.dialogFormVisible = true
    },
    del(teaId){
      this.request.delete("http://localhost:9090/electclass/" + teaId).then(res => {
        if (res) {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },

    delClass(row){
      console.log("退课信息：")
      console.log(row.couId,row.teaId)
      this.request.delete('http://localhost:9090/electclass/delcourse/' + this.user.stuId + "/" + row.couId + "/" + row.teaId).then(res =>{
        if(!res){
          console.log(res)
          this.$message.success("退课成功")
          this.load()
        }else{
          this.$message.error("退课失败")
        }
      })
    },

    handleSelectionChange(val){
      this.multipleSelection = val
    },
    delBatch() {
      let ids = this.multipleSelection.map(v => v.teaId)  // [{}, {}, {}] => [1,2,3]
      this.request.post("http://localhost:9090/electclass/del/batch", ids).then(res => {
        if (res) {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },

    //学生信息添加
    stuadd(){
      this.dialogFormVisible = true
      this.form = {}
    },
    gradesave(fromname){
      this.$refs[fromname].validate((valid) => {
        if(valid){
          console.log(this.form)
          if (this.form.cj == "")
            this.form.cj = 0
          this.request.post("http://localhost:9090/electclass/updategrade/"+ this.form.stuId + "/" + this.form.couId + "/" + this.form.teaId + "/" + this.form.cj).then(res => {
            if (res) {
              this.$message.success("保存成功")
              this.dialogFormVisible = false
              this.load()
            } else {
              this.$message.error("保存失败")
            }
          })
        }
        else {
          console.log('error submit!!');
          return false;
        }
      })
    },


    handleSizeChange(pageSize){
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum){
      this.pageNum = pageNum
      this.load()
    },
  }
}
</script>

<style>
.headerBg {
    background: #eee!important;
  }
</style>