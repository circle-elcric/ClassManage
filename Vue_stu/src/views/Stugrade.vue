<template>
  <div>
    <div style="margin-bottom: 30px">
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/s' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>成绩查询</el-breadcrumb-item>
      </el-breadcrumb>
    </div>

<!--    <div style="margin: 10px 0">-->
<!--      <el-radio-group style="margin-left: 60vh" v-model="xq" @change="load">-->
<!--        <el-radio-button label="秋" value="秋季学期" ></el-radio-button>-->
<!--        <el-radio-button label="冬" value="冬季学期"></el-radio-button>-->
<!--        <el-radio-button label="春" value="春季学期"></el-radio-button>-->
<!--        <el-radio-button label="夏" value="夏季学期"></el-radio-button>-->
<!--      </el-radio-group>-->
<!--    </div>-->

    <el-card style="width: 700px;height: 550px">
      <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
        <el-tab-pane label="秋季学期" name="first">
          <div id="grades1" style="width: 700px;height: 500px">
          </div>
        </el-tab-pane>
        <el-tab-pane label="春季学期" name="second">
          <div id="grades2" style="width: 700px;height: 500px">
        </div>
        </el-tab-pane>
        <el-tab-pane label="冬季学期" name="third">
          <div id="grades3" style="width: 700px;height: 500px">
          </div>
        </el-tab-pane>
        <el-tab-pane label="夏季学期" name="fourth">
          <div id="grades4" style="width: 700px;height: 500px">
          </div>
        </el-tab-pane>
      </el-tabs>

    </el-card>

    <el-card style="width: 700px;height: 550px;top:16%;left:56%;position:absolute;">
          <el-tabs v-model="activeName2" type="card" @tab-click="handleClick2">
            <el-tab-pane label="秋季学期" name="first2">
              <div id="grades12" style="width: 700px;height: 500px">
              </div>
            </el-tab-pane>
            <el-tab-pane label="春季学期" name="second2">
              <div id="grades22" style="width: 700px;height: 500px">
            </div>
            </el-tab-pane>
            <el-tab-pane label="冬季学期" name="third2">
              <div id="grades32" style="width: 700px;height: 500px">
              </div>
            </el-tab-pane>
            <el-tab-pane label="夏季学期" name="fourth2">
              <div id="grades42" style="width: 700px;height: 500px">
              </div>
            </el-tab-pane>
          </el-tabs>

    </el-card>
  </div>
</template>

<script>
import * as echarts from "echarts";
import course from "@/views/Course";
export default {
  name: "Grade",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      stuId: "",
      teaId: "",
      couId: "",
      tname:"",
      cname:"",
      xq:"秋",  //课程学期
      time:"",  //课程时间
      cj: "",  //成绩
      point: "",  //成绩
      multipleSelection: [],
      dialogFormVisible: false,
      form: {},
      formLabelWidth: "80px",
      user:localStorage.getItem("user")?JSON.parse(localStorage.getItem("user")):{},
      radio:localStorage.getItem("radio")?JSON.parse(localStorage.getItem("radio")):{},

      //echarts
      courseData:[],
      gradeData:[],
      pointData:[],
      activeName: 'first',
      activeName2: 'first2'
    }
  },
  created() {
    this.load(this.xq)
  },
  mounted() {
    //解决了Vue中数组push后显示为__ob__导致取不出来的问题
    setTimeout(()=>{
      this.loadgradesbar(this.courseData,this.gradeData,'grades1'),
      this.loadgradesbar2(this.courseData,this.pointData,'grades12')
    },80)
  },
  methods:{
    handleClick(tab, event) {
      if(tab.name == 'first'){
        this.load('秋季学期')
        setTimeout(()=>{
          this.loadgradesbar(this.courseData,this.gradeData,'grades1')
        },80)
      }
      else if(tab.name == 'second'){
        this.load('冬季学期')
        setTimeout(()=>{
          this.loadgradesbar(this.courseData,this.gradeData,'grades2')
        },80)
      }
      else if(tab.name == 'third'){
        this.load('春季学期')
        setTimeout(()=>{
          this.loadgradesbar(this.courseData,this.gradeData,'grades3')
        },80)
      }
      else if(tab.name == 'fourth'){
        this.load('冬季学期')
        setTimeout(()=>{
          this.loadgradesbar(this.courseData,this.gradeData,'grades4')
        },80)
      }
    },
    handleClick2(tab, event) {
          if(tab.name == 'first2'){
            this.load('秋季学期')
            setTimeout(()=>{
              this.loadgradesbar2(this.courseData,this.pointData,'grades12')
            },80)
          }
          else if(tab.name == 'second2'){
            this.load('冬季学期')
            setTimeout(()=>{
              this.loadgradesbar2(this.courseData,this.pointData,'grades22')
            },80)
          }
          else if(tab.name == 'third2'){
            this.load('春季学期')
            setTimeout(()=>{
              this.loadgradesbar2(this.courseData,this.pointData,'grades32')
            },80)
          }
          else if(tab.name == 'fourth2'){
            this.load('冬季学期')
            setTimeout(()=>{
              this.loadgradesbar2(this.courseData,this.pointData,'grades42')
            },80)
          }
        },
    load(val){
      this.request.get("http://localhost:9090/electclass/gradepage",{
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          stuId: this.user.stuId,
          couId: this.couId,
          teaId: this.teaId,
          xq:val,
        }
      }).then(res =>{
        this.courseData = []
        this.gradeData = []
        this.pointData = []
        console.log(res)
        console.log(this.user)
        this.tableData = res.records
        this.total = res.total
        let len = this.tableData.length
        for(let i = 0;i<len;i++){
          this.courseData.push(this.tableData[i].cname)
          this.gradeData.push(this.tableData[i].cj)
          this.pointData.push(this.tableData[i].point)
        }
        console.log(this.courseData)
      })
    },
    loadgradesbar(courseData,gradeData,stringId){

      let chartDom = document.getElementById(stringId)
      let myChart = echarts.init(chartDom)
      let option
      console.log(this.courseData)
      option={
        xAxis: {
          type: 'category',
          data:courseData
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data:gradeData,
            type: 'bar',
            barWidth: '60%',
            itemStyle: {
              barBorderRadius: 5,
              borderWidth: 1,
              borderType: 'solid',
              borderColor: '#73c0de',
              shadowColor: '#5368c7',
              shadowBlur: 3,
            }
          }
        ]
      }
      myChart.setOption(option)
    },
    loadgradesbar2(courseData,pointData,stringId){

          let chartDom = document.getElementById(stringId)
          let myChart = echarts.init(chartDom)
          let option
          console.log(this.pointData)
          option={
            xAxis: {
              type: 'category',
              data:courseData
            },
            yAxis: {
              type: 'value'
            },
            series: [
              {
                data:pointData,
                type: 'bar',
                barWidth: '60%',
                itemStyle: {
                  barBorderRadius: 5,
                  borderWidth: 1,
                  borderType: 'solid',
                  borderColor: '#73c0de',
                  shadowColor: '#5368c7',
                  shadowBlur: 3,
                }
              }
            ]
          }
          myChart.setOption(option)
        },

  }
}
</script>

<style>
.headerBg {
    background: #eee!important;
  }

.grades{
  margin-left: 50px;
}
</style>