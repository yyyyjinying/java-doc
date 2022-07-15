function minmumNumberOfHost(n, arrs){
    // [[1,4], [2,3]]
    const start = [];
    const end = [];
    for(let i = 0; i < n; i++){
        start[i] = arrs[i][0];
        end[i] = arrs[i][1];
    }

    start.sort((a,b) => a - b);
    end.sort((a,b) => a - b);
    console.log(start, end)

    let res = 0;
    let j = 0;
    for(let i = 0; i < n; i++){
        // 新开始的时间大于结束的时间表示不重合
        if(start[i] >= end[j]){
            j++;
        } else {
            res++;
        }

    }

    return res;
}

// console.log(minmumNumberOfHost(2, [[1,4], [2,3]]));

// 输入： [2,4,5],[1,3,6,7]
// 返回值：[1,2,3,4,5,6]

function merge(arr1, arr2){
    const newArr = [];
    let i = 0, j = 0, p = 0;
    while(i < arr1.length && j < arr2.length){
        newArr[p++] = arr1[i] < arr2[j] ? arr1[i++] : arr2[j++];
    }

    while(i < arr1.length){
        newArr[p++] = arr1[i++];
    }
    while(j < arr2.length){
        newArr[p++] = arr2[j++];
    }

    for(let i = 0; i < p; i++){
        arr1[i] = newArr[i];
    }

    console.log(arr1);
}

// merge([2,4,5], [1,3,6]);

/**
 * 什么是回文字符串？
"absba"： true
"a": true
"ranko": false
 */
function judge(str){
    let start = 0;
    let end = str.length - 1;
    while(start < end){
        if(str.charAt(start) === str.charAt(end)){
            start++;
            end--; 
        } else {
            return false;
        }
    }

    return true;
}

// console.log(judge("abcba"));

function mergeArrs(arr){
    // 先按照第一个树升序排序
    arr.sort((a,b) => a[0] - b[0]);
    console.log(arr)

    const result = [arr[0]];

    for(let i = 1; i < arr.length; i++){
        // result 最后一个元素的end值大于arr[i]的start值时，需要合并
        if(result[result.length - 1][1] >= arr[i][0]){
            if(result[result.length - 1][1] <= arr[i][1]){
                result[result.length - 1][1] = arr[i][1];
            }
            continue;
        }else{
            result.push(arr[i]);
        }
    }
    return result;
}

console.log(mergeArrs([[20,60],[10,30],[80,100],[150,180]]));

