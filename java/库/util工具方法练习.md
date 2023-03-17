1. 数据类型转换
Convert.toDouble() 
2. StrUtil.splitToArray()
   字符串工具
3. 随机数的生成
   RandomUtil.randomInt(5,30) * 1000
4. HttpRequest.post().form().execute().body();
5. DateUtil.parse("2020-09-09 00:00:00").getTime() / 1000
6. JSONUtil.toJsonStr(list)
7. MapUtil.builder(new HashMap(String, Object)).put().put().build();
8. List<Object> list = new ArrayList(); list.add(MapUtil.builder().put().put().build());
9. JSONUtil.praseObj(obj)
10. BeanUtil.toBeanIgnoreError(target, Result.clsss); 如果字段相等就考呗，可以使用别名来不同字段也可以拷贝；如果还是不行，就手动拷贝；
11. CollUtil.isEmpty() Collections.emptyList();
12. CollUtil.getFeildValues(list, "id"); ["a","b"]
13. DateUtil.beginOfMonth(today).time(), DateUtil.endOfMonth(today).time() 本月的时间范围
14. JSONObject jsonObject = JSONUtil.parseObj(jsonData);
JSONArray routes = jsonObject.getJSONObject("result")
String vertexes = CollUtil.join(electronicFence.getMutiPoints().stream()
                .map(locationPoint -> locationPoint.getLat() + "," + locationPoint.getLng())
                .collect(Collectors.toList()), ";");
electronicFenceList.stream()
                .map(electronicFence -> MapUtil.builder()
                        .put("id", electronicFence.getId().toString())
                        .put("name", electronicFence.getName()).build())
                .collect(Collectors.toList());
15. //获取发件人的详细地址
        String senderAddress = StrUtil.format("{}{}{}{}",
                wayBill.getSenderProvince().getName(),
                wayBill.getSenderCity().getName(),
                wayBill.getSenderCounty().getName(),
                wayBill.getSenderAddress());
16. CollUtil.isEmpty(jsonArray)
   StrUtil.equals("out",aa)
17. BeanUtil.toBeanIgnoreError(vehicle, VehicleVo.class)
18. Set<String> set = new HashSet<>(Arrays.asList(s[2].split(",")));
19. @Override
    public List<CardEntityDto> getlistAttractInvestment() {
        String url = host + "/web/cm/open/api/listAttractInvestment";
        ArrayList<CardEntityDto> list = new ArrayList<>();
        String response = HttpTool.doGET(url);
        JSONObject jsonObject = JSONObject.parseObject(response);
        for (Object item : jsonObject.getJSONArray("result")) {
            CardEntityDto cardEntityDto = JSONObject.toJavaObject((JSON) item, CardEntityDto.class);
            if (cardEntityDto != null) {
                list.add(cardEntityDto);
            }
        }
        return list;
    }
20. List<Object> list = new ArrayList<>();
        list.add(MapUtil.builder().put("a", "123").put("b", "456").build());
        String s = JSONUtil.toJsonStr(list);

        log.info("{}", s);
        JSONArray objects = JSONUtil.parseArray(s);
        for (Object object : objects) {
            String s1 = JSONUtil.toJsonStr(object);
            Map<String,Object> mm = JSONObject.parseObject(s1, new TypeReference<Map<String, Object>>(){});
            log.info("----{}", mm.get("a"));
        }