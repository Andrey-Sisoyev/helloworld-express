utils = require './lib/utils'

getRandomInt = -> utils.getRandomInt 1, 1000

agen1 = (name, cb1) ->
    utils.setTimeout0 ->
        cb1 name + getRandomInt()  

agen2 = (name1, name2, cb2) ->
    utils.setTimeout0 ->
        cb1 name1 + getRandomInt(), name2 + getRandomInt()  
        
i = undefined
l = undefined
out = undefined
z = undefined
x = null
console.log x

cases =
    _1 : (fName) -> 
        await agen1 'A', defer a
        console.log fName + ' i: ' + a
        ###
        
        Case _1

        ...
        _1 i: A479

        ###

    _2 : (fName) -> 
        await 
            agen1 'A', defer a
            console.log fName + ' i: ' + a # a is undefined here
        console.log fName + ' ii: ' + a
        ###
        
        Case _2
        _2 i: undefined

        ...
        _2 ii: A562

        ###

    _3 : (fName) -> 
        await 
            agen1 'A', defer a
            agen1 'B', defer b
            console.log fName + ' iA: ' + a # a is undefined here
            console.log fName + ' iB: ' + b # b is undefined here
        console.log fName + ' iiA: ' + a
        console.log fName + ' iiB: ' + b
        ###
        
        Case _3
        _3 iA: undefined
        _3 iB: undefined

        ...
        _3 iiA: A76
        _3 iiB: B946


        ###

    _4 : (fName) -> 
        await 
            x = 3
            console.log fName + ' x: ' + x
            if x > 5
                agen1 'A', defer a
            else
                agen1 'B', defer b
            console.log fName + ' iA: ' + a # a is undefined here
            console.log fName + ' iB: ' + b # b is undefined here
        console.log fName + ' iiA: ' + a # a is undefined here
        console.log fName + ' iiB: ' + b
        ###
        
        Case _4
        _4 x: 3
        _4 iA: undefined
        _4 iB: undefined

        ...
        _4 iiA: undefined
        _4 iiB: B53

        ###

    _5 : (fName) -> 
        await 
            x = 7
            console.log fName + ' x: ' + x
            if x > 5
                agen1 'A', defer a
            else
                agen1 'B', defer b
            console.log fName + ' iA: ' + a # a is undefined here
            console.log fName + ' iB: ' + b # b is undefined here
        console.log fName + ' iiA: ' + a
        console.log fName + ' iiB: ' + b # b is undefined here
        ###
        
        Case _5
        _5 x: 7
        _5 iA: undefined
        _5 iB: undefined

        ...
        _5 iiA: A5
        _5 iiB: undefined

        ###

    _6 : (fName) -> # wrong use
        await 
            l = utils.getRandomInt 5, 10
            console.log fName + ' iL: ' + l
            out = []
            for i in [1..l]
                agen1 'Z', defer z
                out.push z # z is undefined here
               
            console.log fName + ' iZ: ' + z # z is undefined here
            console.log fName + ' iOut: ' + out + ' ' # out is filled with 10 undefined values
        console.log fName + ' iiL: ' + l
        console.log fName + ' iiZ: ' + z
        console.log fName + ' iiOut: ' + out + typeof out # ???
        ###
        
        Case _6
        _6 iL: 8
        _6 iZ: undefined
        _6 iOut: ,,,,,,,

        ...
        _6 iiL: 8
        _6 iiZ: Z585
        _6 iiOut: object


        ###

    _7 : (fName) -> # successfull use
        await 
            l = utils.getRandomInt 5, 10
            console.log fName + ' iL: ' + l
            out = []
            for i in [0..l]
                agen1 'Z', defer out[i] # the only way to make it work?
               
            console.log fName + ' iOut: ' + out + ' ' + typeof out # ???
        console.log fName + ' iiL: ' + l
        console.log fName + ' iiOut: ' + out
        ###
        
        Case _7
        _7 iL: 8
        _7 iOut: object

        ...
        _7 iiL: 8
        _7 iiOut: Z937,Z723,Z859,Z358,Z575,Z125,Z10,Z702,Z821

        ###


exports.run = ->
    for own key, value of cases
        console.log '\nCase ' + key 
        value key  