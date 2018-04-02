        Label        -mem-manager-initialize   
        DLabel       $heap-start-ptr           
        DataZ        4                         
        DLabel       $heap-after-ptr           
        DataZ        4                         
        DLabel       $heap-first-free          
        DataZ        4                         
        DLabel       $mmgr-newblock-block      
        DataZ        4                         
        DLabel       $mmgr-newblock-size       
        DataZ        4                         
        PushD        $heap-memory              
        Duplicate                              
        PushD        $heap-start-ptr           
        Exchange                               
        StoreI                                 
        PushD        $heap-after-ptr           
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        Jump         $$main                    
        DLabel       $eat-location-zero        
        DataZ        8                         
        DLabel       $print-format-integer     
        DataC        37                        %% "%d"
        DataC        100                       
        DataC        0                         
        DLabel       $print-format-floating    
        DataC        37                        %% "%g"
        DataC        103                       
        DataC        0                         
        DLabel       $print-format-boolean     
        DataC        37                        %% "%s"
        DataC        115                       
        DataC        0                         
        DLabel       $print-format-character   
        DataC        37                        %% "%c"
        DataC        99                        
        DataC        0                         
        DLabel       $print-format-string      
        DataC        37                        %% "%s"
        DataC        115                       
        DataC        0                         
        DLabel       $print-format-tab         
        DataC        9                         %% "\t"
        DataC        0                         
        DLabel       $print-format-newline     
        DataC        10                        %% "\n"
        DataC        0                         
        DLabel       $print-format-space       
        DataC        32                        %% " "
        DataC        0                         
        DLabel       $boolean-true-string      
        DataC        116                       %% "true"
        DataC        114                       
        DataC        117                       
        DataC        101                       
        DataC        0                         
        DLabel       $boolean-false-string     
        DataC        102                       %% "false"
        DataC        97                        
        DataC        108                       
        DataC        115                       
        DataC        101                       
        DataC        0                         
        DLabel       $dash-string              
        DataC        95                        %% "_"
        DataC        0                         
        DLabel       $divide-sign-string       
        DataC        47                        %% "/"
        DataC        0                         
        DLabel       $minus-sign-string        
        DataC        45                        %% "-"
        DataC        0                         
        DLabel       $open-bracket-string      
        DataC        91                        %% "["
        DataC        0                         
        DLabel       $close-bracket-string     
        DataC        93                        %% "]"
        DataC        0                         
        DLabel       $comma-string             
        DataC        44                        %% ","
        DataC        0                         
        DLabel       $errors-general-message   
        DataC        82                        %% "Runtime error: %s\n"
        DataC        117                       
        DataC        110                       
        DataC        116                       
        DataC        105                       
        DataC        109                       
        DataC        101                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        58                        
        DataC        32                        
        DataC        37                        
        DataC        115                       
        DataC        10                        
        DataC        0                         
        Label        $$general-runtime-error   
        PushD        $errors-general-message   
        Printf                                 
        Halt                                   
        DLabel       $errors-int-divide-by-zero 
        DataC        105                       %% "integer divide by zero"
        DataC        110                       
        DataC        116                       
        DataC        101                       
        DataC        103                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$i-divide-by-zero        
        PushD        $errors-int-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $errors-float-divide-by-zero 
        DataC        102                       %% "float divide by zero"
        DataC        108                       
        DataC        111                       
        DataC        97                        
        DataC        116                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$f-divide-by-zero        
        PushD        $errors-float-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $null-array-runtime-error 
        DataC        110                       %% "null array"
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        0                         
        Label        $$null-array              
        PushD        $null-array-runtime-error 
        Jump         $$general-runtime-error   
        DLabel       $index-out-of-bound-error 
        DataC        97                        %% "array index out of bound"
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        105                       
        DataC        110                       
        DataC        100                       
        DataC        101                       
        DataC        120                       
        DataC        32                        
        DataC        111                       
        DataC        117                       
        DataC        116                       
        DataC        32                        
        DataC        111                       
        DataC        102                       
        DataC        32                        
        DataC        98                        
        DataC        111                       
        DataC        117                       
        DataC        110                       
        DataC        100                       
        DataC        0                         
        Label        $$index-out-of-bound      
        PushD        $index-out-of-bound-error 
        Jump         $$general-runtime-error   
        DLabel       $zero-denominator-error   
        DataC        111                       %% "over zero denominator"
        DataC        118                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        32                        
        DataC        100                       
        DataC        101                       
        DataC        110                       
        DataC        111                       
        DataC        109                       
        DataC        105                       
        DataC        110                       
        DataC        97                        
        DataC        116                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $$over-zero-denominator   
        PushD        $zero-denominator-error   
        Jump         $$general-runtime-error   
        DLabel       $expressover-divide-by-zero 
        DataC        101                       %% "expressover divide by zero"
        DataC        120                       
        DataC        112                       
        DataC        114                       
        DataC        101                       
        DataC        115                       
        DataC        115                       
        DataC        111                       
        DataC        118                       
        DataC        101                       
        DataC        114                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$rational-expressover-divide-by-zero 
        PushD        $expressover-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $rationalize-divide-by-zero 
        DataC        114                       %% "rationalize divide by zero"
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        111                       
        DataC        110                       
        DataC        97                        
        DataC        108                       
        DataC        105                       
        DataC        122                       
        DataC        101                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        118                       
        DataC        105                       
        DataC        100                       
        DataC        101                       
        DataC        32                        
        DataC        98                        
        DataC        121                       
        DataC        32                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        0                         
        Label        $$rationalize-divide-by-zero 
        PushD        $rationalize-divide-by-zero 
        Jump         $$general-runtime-error   
        DLabel       $negative-array-length    
        DataC        110                       %% "negative array length"
        DataC        101                       
        DataC        103                       
        DataC        97                        
        DataC        116                       
        DataC        105                       
        DataC        118                       
        DataC        101                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        108                       
        DataC        101                       
        DataC        110                       
        DataC        103                       
        DataC        116                       
        DataC        104                       
        DataC        0                         
        Label        $$negative-length-array   
        PushD        $negative-array-length    
        Jump         $$general-runtime-error   
        DLabel       $null-string-runtime-error 
        DataC        110                       %% "null string"
        DataC        117                       
        DataC        108                       
        DataC        108                       
        DataC        32                        
        DataC        115                       
        DataC        116                       
        DataC        114                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        0                         
        Label        $$null-string             
        PushD        $null-string-runtime-error 
        Jump         $$general-runtime-error   
        DLabel       $no-return                
        DataC        110                       %% "no return"
        DataC        111                       
        DataC        32                        
        DataC        114                       
        DataC        101                       
        DataC        116                       
        DataC        117                       
        DataC        114                       
        DataC        110                       
        DataC        0                         
        Label        $$no return               
        PushD        $no-return                
        Jump         $$general-runtime-error   
        DLabel       $string-slice-index-error 
        DataC        115                       %% "string slice index error"
        DataC        116                       
        DataC        114                       
        DataC        105                       
        DataC        110                       
        DataC        103                       
        DataC        32                        
        DataC        115                       
        DataC        108                       
        DataC        105                       
        DataC        99                        
        DataC        101                       
        DataC        32                        
        DataC        105                       
        DataC        110                       
        DataC        100                       
        DataC        101                       
        DataC        120                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $$string-slice-index-error 
        PushD        $string-slice-index-error 
        Jump         $$general-runtime-error   
        DLabel       $zip-array-length-different 
        DataC        122                       %% "zip array different error"
        DataC        105                       
        DataC        112                       
        DataC        32                        
        DataC        97                        
        DataC        114                       
        DataC        114                       
        DataC        97                        
        DataC        121                       
        DataC        32                        
        DataC        100                       
        DataC        105                       
        DataC        102                       
        DataC        102                       
        DataC        101                       
        DataC        114                       
        DataC        101                       
        DataC        110                       
        DataC        116                       
        DataC        32                        
        DataC        101                       
        DataC        114                       
        DataC        114                       
        DataC        111                       
        DataC        114                       
        DataC        0                         
        Label        $zip-length-different     
        PushD        $zip-array-length-different 
        Jump         $$general-runtime-error   
        DLabel       $fold-zero-length         
        DataC        102                       %% "fold-zero-length"
        DataC        111                       
        DataC        108                       
        DataC        100                       
        DataC        45                        
        DataC        122                       
        DataC        101                       
        DataC        114                       
        DataC        111                       
        DataC        45                        
        DataC        108                       
        DataC        101                       
        DataC        110                       
        DataC        103                       
        DataC        116                       
        DataC        104                       
        DataC        0                         
        Label        $$fold-zero-length        
        PushD        $fold-zero-length         
        Jump         $$general-runtime-error   
        DLabel       $a-indexing-array         
        DataZ        4                         
        DLabel       $a-indexing-index         
        DataZ        4                         
        DLabel       $express-over-denominator 
        DataZ        4                         
        DLabel       $rational-denominator-temp 
        DataZ        4                         
        DLabel       $rational-numerator-temp  
        DataZ        4                         
        DLabel       $rational-denominator-temp2 
        DataZ        4                         
        DLabel       $rational-numerator-temp2 
        DataZ        4                         
        DLabel       $rational-print-integer-part 
        DataZ        4                         
        DLabel       $rational-print-remainder 
        DataZ        4                         
        DLabel       $rational-print-sign      
        DataZ        4                         
        DLabel       $record-creation-temp     
        DataZ        4                         
        DLabel       $array-datasize-temp      
        DataZ        4                         
        DLabel       $array-identifier-temp    
        DataZ        4                         
        DLabel       $array-status-temp        
        DataZ        4                         
        DLabel       $array-subtype-size-temp  
        DataZ        4                         
        DLabel       $array-length-temp        
        DataZ        4                         
        DLabel       $array-element-temp       
        DataZ        4                         
        DLabel       $cloned-array-temp        
        DataZ        4                         
        DLabel       $print-string-temp        
        DataZ        4                         
        DLabel       $print-string-length      
        DataZ        4                         
        DLabel       $frame-pointer            
        DataZ        4                         
        DLabel       $stack-pointer            
        DataZ        4                         
        DLabel       $slice-string-index1      
        DataZ        4                         
        DLabel       $slice-string-index2      
        DataZ        4                         
        DLabel       $slice-string-address     
        DataZ        4                         
        DLabel       $string-element-temp1     
        DataZ        4                         
        DLabel       $string-element-temp2     
        DataZ        4                         
        DLabel       $string-length-temp       
        DataZ        4                         
        DLabel       $string-addr-temp1        
        DataZ        4                         
        DLabel       $string-addr-temp2        
        DataZ        4                         
        DLabel       $for-index                
        DataZ        4                         
        DLabel       $for-expression           
        DataZ        4                         
        DLabel       $for-length               
        DataZ        4                         
        DLabel       $for-subsize              
        DataZ        4                         
        DLabel       $for-identifier           
        DataZ        4                         
        DLabel       $array-address            
        DataZ        4                         
        DLabel       $lambda-address           
        DataZ        4                         
        DLabel       $array-element-temp2      
        DataZ        4                         
        DLabel       $array-address-S          
        DataZ        4                         
        DLabel       $array-address-T          
        DataZ        4                         
        DLabel       $array-element-temp3      
        DataZ        4                         
        DLabel       $param-u                  
        DataZ        4                         
        DLabel       $call-result              
        DataZ        4                         
        DLabel       $char-temp                
        DataZ        1                         
        Label        $lowest-term-subroutine   
        DLabel       $lowest-term-return       
        DataZ        4                         
        PushD        $lowest-term-return       
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        DLabel       $lowest-term-denominator  
        DataZ        4                         
        DLabel       $lowest-term-numerator    
        DataZ        4                         
        DLabel       $lowest-term-gcd          
        DataZ        4                         
        DLabel       $lowest-term-tmpa         
        DataZ        4                         
        DLabel       $lowest-term-tmpb         
        DataZ        4                         
        PushD        $lowest-term-denominator  
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-numerator    
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Subtract                               
        JumpNeg      -lowest-term-subroutine-3-exchange 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-denominator  
        LoadI                                  
        Jump         -lowest-term-subroutine-3-loop-start 
        Label        -lowest-term-subroutine-3-exchange 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-numerator    
        LoadI                                  
        Label        -lowest-term-subroutine-3-loop-start 
        PushD        $lowest-term-tmpb         
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-tmpa         
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-tmpa         
        LoadI                                  
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Duplicate                              
        JumpFalse    -lowest-term-subroutine-3-end 
        Remainder                              
        PushD        $lowest-term-tmpb         
        LoadI                                  
        Exchange                               
        Jump         -lowest-term-subroutine-3-loop-start 
        Label        -lowest-term-subroutine-3-end 
        Pop                                    
        PushD        $lowest-term-gcd          
        Exchange                               
        StoreI                                 
        PushD        $lowest-term-numerator    
        LoadI                                  
        PushD        $lowest-term-gcd          
        LoadI                                  
        Divide                                 
        PushD        $lowest-term-denominator  
        LoadI                                  
        PushD        $lowest-term-gcd          
        LoadI                                  
        Divide                                 
        PushD        $lowest-term-return       
        LoadI                                  
        Return                                 
        Label        $clear-n-bytes-subroutine 
        DLabel       $clear-n-bytes-return-address 
        DataZ        4                         
        PushD        $clear-n-bytes-return-address 
        Exchange                               
        StoreI                                 
        DLabel       $clear-n-bytes-element-size 
        DataZ        4                         
        PushD        $clear-n-bytes-element-size 
        Exchange                               
        StoreI                                 
        DLabel       $clear-n-bytes-element-addr 
        DataZ        4                         
        PushD        $clear-n-bytes-element-addr 
        Exchange                               
        StoreI                                 
        Label        -clear-n-bytes-subroutine-4-loop-start 
        PushD        $clear-n-bytes-element-size 
        LoadI                                  
        JumpFalse    -clear-n-bytes-subroutine-4-end 
        PushI        0                         
        PushD        $clear-n-bytes-element-addr 
        Exchange                               
        StoreC                                 
        PushI        1                         
        PushD        $clear-n-bytes-element-addr 
        LoadI                                  
        Add                                    
        PushD        $clear-n-bytes-element-addr 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $clear-n-bytes-element-size 
        LoadI                                  
        Add                                    
        PushD        $clear-n-bytes-element-size 
        Exchange                               
        StoreI                                 
        Jump         -clear-n-bytes-subroutine-4-loop-start 
        Label        -clear-n-bytes-subroutine-4-end 
        PushD        $clear-n-bytes-return-address 
        LoadI                                  
        Return                                 
        Label        $print-array-subroutine   
        DLabel       -print-array-recursive-5-return-address 
        DataZ        4                         
        PushD        -print-array-recursive-5-return-address 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-5-type 
        DataZ        4                         
        PushD        -print-array-recursive-5-type 
        Exchange                               
        StoreI                                 
        DLabel       -print-array-recursive-5-element 
        DataZ        4                         
        DLabel       -print-array-recursive-5-length 
        DataZ        4                         
        DLabel       -print-array-recursive-5-elem-size 
        DataZ        4                         
        DLabel       -print-array-recursive-5-array 
        DataZ        4                         
        Duplicate                              
        JumpFalse    $$null-array              
        Duplicate                              
        Duplicate                              
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -print-array-recursive-5-elem-size 
        Exchange                               
        StoreI                                 
        PushD        $open-bracket-string      
        PushD        $print-format-string      
        Printf                                 
        Duplicate                              
        PushD        -print-array-recursive-5-array 
        Exchange                               
        StoreI                                 
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        2                         
        BTAnd                                  
        JumpFalse    -print-array-recursive-5-one-dim 
        Label        -print-array-recursive-5-loop-start 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-5-end 
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        LoadI                                  
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-one-dim 
        PushD        -print-array-recursive-5-return-address 
        LoadI                                  
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        PushD        -print-array-recursive-5-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        LoadI                                  
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        Call         $print-array-subroutine   
        PushD        -print-array-recursive-5-elem-size 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-type 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-return-address 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-loop-start 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-5-loop-start 
        Label        -print-array-recursive-5-one-dim 
        Label        -print-array-recursive-5-loop-start-2 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        JumpFalse    -print-array-recursive-5-end 
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-int-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        2                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-float-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        3                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-char-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-string-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        5                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-rat-label 
        PushD        -print-array-recursive-5-type 
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-bool-label 
        Label        -print-array-recursive-5-int-label 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-float-label 
        LoadF                                  
        PushD        $print-format-floating    
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-char-label 
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-rat-label 
        Duplicate                              
        LoadI                                  
        Exchange                               
        PushI        4                         
        Add                                    
        LoadI                                  
        Call         $print-rational           
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-bool-label 
        LoadC                                  
        Call         $convert-to-string-if-bool-subroutine 
        PushD        $print-format-boolean     
        Printf                                 
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-string-label 
        LoadI                                  
        Call         $print-string             
        Jump         -print-array-recursive-5-join-label 
        Label        -print-array-recursive-5-join-label 
        PushD        -print-array-recursive-5-elem-size 
        LoadI                                  
        PushD        -print-array-recursive-5-element 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        Add                                    
        PushD        -print-array-recursive-5-length 
        Exchange                               
        StoreI                                 
        PushD        -print-array-recursive-5-length 
        LoadI                                  
        PushI        0                         
        Subtract                               
        JumpFalse    -print-array-recursive-5-loop-start-2 
        PushD        $comma-string             
        PushD        $print-format-string      
        Printf                                 
        PushD        $print-format-space       
        PushD        $print-format-string      
        Printf                                 
        Jump         -print-array-recursive-5-loop-start-2 
        Label        -print-array-recursive-5-end 
        PushD        $close-bracket-string     
        PushD        $print-format-string      
        Printf                                 
        PushD        -print-array-recursive-5-return-address 
        LoadI                                  
        Return                                 
        Label        $print-rational           
        DLabel       $print-rational-return-address 
        DataZ        4                         
        PushD        $print-rational-return-address 
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$over-zero-denominator   
        Duplicate                              
        JumpPos      -print-rational-6-denominator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-6-denominator-pos 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        Duplicate                              
        Duplicate                              
        JumpFalse    -print-rational-6-zero-numerator 
        JumpPos      -print-rational-6-numerator-pos 
        PushD        $rational-print-sign      
        LoadI                                  
        Negate                                 
        PushD        $rational-print-sign      
        Exchange                               
        StoreI                                 
        Negate                                 
        Label        -print-rational-6-numerator-pos 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $rational-denominator-temp 
        LoadI                                  
        Remainder                              
        PushD        $rational-numerator-temp  
        LoadI                                  
        PushD        $rational-denominator-temp 
        LoadI                                  
        Divide                                 
        PushD        $rational-print-integer-part 
        Exchange                               
        StoreI                                 
        PushD        $rational-print-remainder 
        Exchange                               
        StoreI                                 
        PushD        $rational-print-remainder 
        LoadI                                  
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $rational-print-sign      
        LoadI                                  
        JumpPos      -print-rational-6-rational-pos 
        PushD        $minus-sign-string        
        PushD        $print-format-string      
        Printf                                 
        Label        -print-rational-6-rational-pos 
        JumpFalse    -print-rational-6-fraction 
        PushD        $rational-print-integer-part 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Label        -print-rational-6-fraction 
        JumpFalse    -print-rational-6-end     
        PushD        $dash-string              
        PushD        $print-format-string      
        Printf                                 
        PushD        $rational-print-remainder 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $divide-sign-string       
        PushD        $print-format-string      
        Printf                                 
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        Jump         -print-rational-6-end     
        Label        -print-rational-6-zero-numerator 
        PushD        $print-format-integer     
        Printf                                 
        Pop                                    
        Label        -print-rational-6-end     
        PushD        $print-rational-return-address 
        LoadI                                  
        Return                                 
        Label        $print-string             
        DLabel       $print-string-return-address 
        DataZ        4                         
        PushD        $print-string-return-address 
        Exchange                               
        StoreI                                 
        Duplicate                              
        JumpFalse    $$null-string             
        Duplicate                              
        PushI        12                        
        Add                                    
        PushD        $print-string-temp        
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        $print-string-length      
        Exchange                               
        StoreI                                 
        Label        -print-string-7-loop-start 
        PushD        $print-string-length      
        LoadI                                  
        JumpFalse    -print-string-7-end       
        PushD        $print-string-temp        
        LoadI                                  
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        PushI        1                         
        PushD        $print-string-temp        
        LoadI                                  
        Add                                    
        PushD        $print-string-temp        
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        $print-string-length      
        LoadI                                  
        Add                                    
        PushD        $print-string-length      
        Exchange                               
        StoreI                                 
        Jump         -print-string-7-loop-start 
        Label        -print-string-7-end       
        PushD        $print-string-return-address 
        LoadI                                  
        Return                                 
        Label        $convert-to-string-if-bool-subroutine 
        DLabel       $convert-to-string-if-bool-return-address 
        DataZ        4                         
        PushD        $convert-to-string-if-bool-return-address 
        Exchange                               
        StoreI                                 
        JumpTrue     -print-boolean-8-true     
        PushD        $boolean-false-string     
        Jump         -print-boolean-8-join     
        Label        -print-boolean-8-true     
        PushD        $boolean-true-string      
        Label        -print-boolean-8-join     
        PushD        $convert-to-string-if-bool-return-address 
        LoadI                                  
        Return                                 
        DLabel       -release-record-9-length  
        DataZ        4                         
        DLabel       -release-record-9-element-size 
        DataZ        4                         
        DLabel       -release-record-9-element 
        DataZ        4                         
        Label        $release-record           
        DLabel       $release-record-return-address 
        DataZ        4                         
        PushD        $release-record-return-address 
        Exchange                               
        StoreI                                 
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Duplicate                              
        Duplicate                              
        PushI        4                         
        BTAnd                                  
        JumpTrue     -release-record-9-end     
        PushI        8                         
        BTAnd                                  
        JumpTrue     -release-record-9-end     
        PushI        2                         
        BTAnd                                  
        JumpFalse    -release-record-9-release 
        Duplicate                              
        Duplicate                              
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-9-element-size 
        Exchange                               
        StoreI                                 
        PushI        16                        
        Add                                    
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        Jump         -release-record-9-join    
        Label        -release-record-9-string-record 
        Duplicate                              
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        -release-record-9-element-size 
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        Label        -release-record-9-join    
        Label        -release-record-9-loop-start 
        PushD        -release-record-9-length  
        LoadI                                  
        JumpFalse    -release-record-9-end     
        PushD        -release-record-9-element 
        LoadI                                  
        PushD        -release-record-9-length  
        LoadI                                  
        PushD        -release-record-9-element-size 
        LoadI                                  
        PushD        $release-record-return-address 
        LoadI                                  
        PushD        -release-record-9-element 
        LoadI                                  
        LoadI                                  
        Duplicate                              
        PushI        0                         
        Add                                    
        LoadI                                  
        PushI        6                         
        Subtract                               
        JumpFalse    -release-record-9-release 
        Call         $release-record           
        PushD        $release-record-return-address 
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-element-size 
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        PushD        -release-record-9-element-size 
        LoadI                                  
        PushD        -release-record-9-element 
        LoadI                                  
        Add                                    
        PushD        -release-record-9-element 
        Exchange                               
        StoreI                                 
        PushI        -1                        
        PushD        -release-record-9-length  
        LoadI                                  
        Add                                    
        PushD        -release-record-9-length  
        Exchange                               
        StoreI                                 
        Jump         -release-record-9-loop-start 
        Label        -release-record-9-release 
        Duplicate                              
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        Call         -mem-manager-deallocate   
        Label        -release-record-9-end     
        PushD        $release-record-return-address 
        LoadI                                  
        Return                                 
        Label        $subtract-rational        
        DLabel       $subtract-rational-return-address 
        DataZ        4                         
        PushD        $subtract-rational-return-address 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp2 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp2 
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        Exchange                               
        StoreI                                 
        PushD        $rational-numerator-temp  
        Exchange                               
        StoreI                                 
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $rational-denominator-temp2 
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp2 
        LoadI                                  
        PushD        $rational-numerator-temp  
        LoadI                                  
        Multiply                               
        PushD        $rational-denominator-temp 
        LoadI                                  
        PushD        $rational-numerator-temp2 
        LoadI                                  
        Multiply                               
        Subtract                               
        Exchange                               
        Call         $lowest-term-subroutine   
        PushD        $subtract-rational-return-address 
        LoadI                                  
        Return                                 
        DLabel       $usable-memory-start      
        DLabel       $global-memory-block      
        DataZ        20                        
        Label        $$main                    
        Memtop                                 
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        Memtop                                 
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% print_str
        DLabel       -function-body-13-return-addr 
        DataZ        4                         
        Jump         -function-body-13--end    
        Label        -function-body-13--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -16                       
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        PushI        6                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        104                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        101                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        108                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        108                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        33                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        DLabel       -for-index-12-for-length  
        DataZ        4                         
        DLabel       -for-index-12-for-index   
        DataZ        4                         
        DLabel       -for-index-12-for-expr    
        DataZ        4                         
        DLabel       -for-index-12-for-subsize 
        DataZ        4                         
        DLabel       -for-index-12-for-indentifier 
        DataZ        4                         
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-string             
        Duplicate                              
        PushD        -for-index-12-for-expr    
        Exchange                               
        StoreI                                 
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -for-index-12-for-length  
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -for-index-12-for-index   
        Exchange                               
        StoreI                                 
        Label        -for-index-12-loop-start  
        PushD        -for-index-12-for-length  
        LoadI                                  
        PushD        -for-index-12-for-index   
        LoadI                                  
        Subtract                               
        JumpPos      -for-index-12-in-label    
        Jump         -for-index-12-exit        
        Label        -for-index-12-in-label    
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        PushD        -for-index-12-for-index   
        LoadI                                  
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-string             
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        1                         
        Subtract                               
        PushD        $print-format-integer     
        Printf                                 
        PushI        1                         
        PushD        -for-index-12-for-index   
        LoadI                                  
        Add                                    
        PushD        -for-index-12-for-index   
        Exchange                               
        StoreI                                 
        Jump         -for-index-12-loop-start  
        Label        -for-index-enter-11-break-target 
        Jump         -for-index-12-exit        
        Label        -for-index-enter-11-continue-target 
        PushI        1                         
        PushD        -for-index-12-for-index   
        LoadI                                  
        Add                                    
        PushD        -for-index-12-for-index   
        Exchange                               
        StoreI                                 
        Jump         -for-index-12-loop-start  
        Label        -for-index-12-exit        
        PushD        $print-format-newline     
        Printf                                 
        Jump         -function-body-10--exit-handshake 
        Jump         $$no return               
        Label        -function-body-10--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-13-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        16                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        -function-body-13-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-13--end    
        PushD        -function-body-13--anonymous-start 
        StoreI                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% points
        PushI        4                         
        PushI        10                        
        Multiply                               
        PushI        16                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        7                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        10                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        DLabel       -populate-creation-14-elemAddr 
        DataZ        4                         
        PushD        $record-creation-temp     
        LoadI                                  
        Duplicate                              
        PushI        16                        
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        1                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        2                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        3                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        4                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        5                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        6                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        7                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        8                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        9                         
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        PushI        10                        
        StoreI                                 
        PushI        4                         
        PushD        -populate-creation-14-elemAddr 
        LoadI                                  
        Add                                    
        PushD        -populate-creation-14-elemAddr 
        Exchange                               
        StoreI                                 
        StoreI                                 
        DLabel       -for-expr-41-for-length   
        DataZ        4                         
        DLabel       -for-expr-41-for-index    
        DataZ        4                         
        DLabel       -for-expr-41-for-expr     
        DataZ        4                         
        DLabel       -for-expr-41-for-subsize  
        DataZ        4                         
        DLabel       -for-expr-41-for-indentifier 
        DataZ        4                         
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% points
        LoadI                                  
        Duplicate                              
        Duplicate                              
        JumpFalse    $$null-array              
        PushD        -for-expr-41-for-expr     
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -for-expr-41-for-length   
        Exchange                               
        StoreI                                 
        PushD        -for-expr-41-for-expr     
        LoadI                                  
        PushI        8                         
        Add                                    
        LoadI                                  
        PushD        -for-expr-41-for-subsize  
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -for-expr-41-for-index    
        Exchange                               
        StoreI                                 
        Label        -for-expr-41-loop-start   
        PushD        -for-expr-41-for-length   
        LoadI                                  
        PushD        -for-expr-41-for-index    
        LoadI                                  
        Subtract                               
        JumpPos      -for-expr-41-in-label     
        Jump         -for-expr-41-exit         
        Label        -for-expr-41-in-label     
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        Duplicate                              
        PushD        -for-expr-41-for-indentifier 
        Exchange                               
        StoreI                                 
        PushD        -for-expr-41-for-expr     
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        -for-expr-41-for-index    
        LoadI                                  
        PushD        -for-expr-41-for-subsize  
        LoadI                                  
        Multiply                               
        Add                                    
        PushD        -for-expr-41-for-subsize  
        LoadI                                  
        PushI        1                         
        Subtract                               
        JumpTrue     -for-expr-41-subsize-four 
        LoadC                                  
        StoreC                                 
        Jump         -for-expr-41-if-end       
        Label        -for-expr-41-subsize-four 
        PushD        -for-expr-41-for-subsize  
        LoadI                                  
        PushI        4                         
        Subtract                               
        JumpTrue     -for-expr-41-subsize-eight 
        LoadI                                  
        StoreI                                 
        Jump         -for-expr-41-if-end       
        Label        -for-expr-41-subsize-eight 
        LoadF                                  
        StoreF                                 
        Label        -for-expr-41-if-end       
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% print_str2
        DLabel       -function-body-23-return-addr 
        DataZ        4                         
        Jump         -function-body-23--end    
        Label        -function-body-23--anonymous-start 
        PushD        $frame-pointer            
        LoadI                                  
        PushD        $stack-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        Exchange                               
        StoreI                                 
        PushD        $stack-pointer            
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        -16                       
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        PushI        6                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        18                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        119                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        111                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        114                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        14                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        108                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        15                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        100                       
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        16                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        33                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        17                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        PushI        0                         
        StoreI                                 
        Label        -while-22-condition       
        Label        -while-enter-17-continue-target 
        Label        -compare-less-18-arg1     
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        LoadI                                  
        Label        -compare-less-18-arg2     
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-string             
        PushI        8                         
        Add                                    
        LoadI                                  
        Label        -compare-less-18-sub      
        Subtract                               
        JumpNeg      -compare-less-18-true     
        Jump         -compare-less-18-false    
        Label        -compare-less-18-true     
        PushI        1                         
        Jump         -compare-less-18-join     
        Label        -compare-less-18-false    
        PushI        0                         
        Jump         -compare-less-18-join     
        Label        -compare-less-18-join     
        JumpTrue     -while-22-true            
        Jump         -while-22-false           
        Label        -while-22-true            
        Label        -if-21-condition          
        Label        -compare-equal-19-arg1    
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-19-arg2    
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-string             
        PushI        8                         
        Add                                    
        LoadI                                  
        PushI        1                         
        Subtract                               
        Label        -compare-equal-19-sub     
        Subtract                               
        JumpFalse    -compare-equal-19-true    
        Jump         -compare-equal-19-false   
        Label        -compare-equal-19-true    
        PushI        1                         
        Jump         -compare-equal-19-join    
        Label        -compare-equal-19-false   
        PushI        0                         
        Jump         -compare-equal-19-join    
        Label        -compare-equal-19-join    
        JumpTrue     -if-21-ifBody             
        Jump         -if-21-elseBody           
        Label        -if-21-ifBody             
        Jump         -while-enter-17-break-target 
        Jump         -for-elem-enter-15-break-target 
        Jump         -if-21-join               
        Label        -if-21-elseBody           
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -12                       
        Add                                    %% str
        LoadI                                  
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        LoadI                                  
        PushD        $a-indexing-index         
        Exchange                               
        StoreI                                 
        PushD        $a-indexing-array         
        Exchange                               
        StoreI                                 
        PushD        $a-indexing-array         
        LoadI                                  
        JumpFalse    $$null-array              
        PushD        $a-indexing-index         
        LoadI                                  
        JumpNeg      $$index-out-of-bound      
        PushD        $a-indexing-index         
        LoadI                                  
        PushD        $a-indexing-array         
        LoadI                                  
        PushI        8                         
        Add                                    
        LoadI                                  
        Subtract                               
        JumpNeg      -array-indexing-20-in-bounds 
        Jump         $$index-out-of-bound      
        Label        -array-indexing-20-in-bounds 
        Nop                                    
        PushD        $a-indexing-array         
        LoadI                                  
        PushI        12                        
        Add                                    
        PushD        $a-indexing-index         
        LoadI                                  
        PushI        1                         
        Multiply                               
        Add                                    
        LoadC                                  
        PushD        $print-format-character   
        Printf                                 
        Label        -if-21-join               
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        PushD        $frame-pointer            
        LoadI                                  
        PushI        -16                       
        Add                                    %% i
        LoadI                                  
        PushI        1                         
        Add                                    
        StoreI                                 
        Jump         -while-22-condition       
        Label        -while-22-false           
        Label        -while-enter-17-break-target 
        Jump         -while-22-join            
        Label        -while-22-join            
        PushD        $print-format-newline     
        Printf                                 
        Jump         -function-body-16--exit-handshake 
        Jump         $$no return               
        Label        -function-body-16--exit-handshake 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        8                         
        Subtract                               
        LoadI                                  
        PushD        -function-body-23-return-addr 
        Exchange                               
        StoreI                                 
        PushD        $frame-pointer            
        LoadI                                  
        PushI        4                         
        Subtract                               
        LoadI                                  
        PushD        $frame-pointer            
        Exchange                               
        StoreI                                 
        PushI        16                        
        PushD        $stack-pointer            
        LoadI                                  
        Add                                    
        PushD        $stack-pointer            
        Exchange                               
        StoreI                                 
        PushD        -function-body-23-return-addr 
        LoadI                                  
        Return                                 
        Label        -function-body-23--end    
        PushD        -function-body-23--anonymous-start 
        StoreI                                 
        Label        -if-25-condition          
        Label        -compare-equal-24-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-24-arg2    
        PushI        7                         
        Label        -compare-equal-24-sub     
        Subtract                               
        JumpFalse    -compare-equal-24-true    
        Jump         -compare-equal-24-false   
        Label        -compare-equal-24-true    
        PushI        1                         
        Jump         -compare-equal-24-join    
        Label        -compare-equal-24-false   
        PushI        0                         
        Jump         -compare-equal-24-join    
        Label        -compare-equal-24-join    
        JumpTrue     -if-25-ifBody             
        Jump         -if-25-elseBody           
        Label        -if-25-ifBody             
        Jump         -for-elem-enter-15-break-target 
        Jump         -if-25-join               
        Label        -if-25-elseBody           
        Label        -if-25-join               
        Label        -if-27-condition          
        Label        -compare-equal-26-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-26-arg2    
        PushI        10                        
        Label        -compare-equal-26-sub     
        Subtract                               
        JumpFalse    -compare-equal-26-true    
        Jump         -compare-equal-26-false   
        Label        -compare-equal-26-true    
        PushI        1                         
        Jump         -compare-equal-26-join    
        Label        -compare-equal-26-false   
        PushI        0                         
        Jump         -compare-equal-26-join    
        Label        -compare-equal-26-join    
        JumpTrue     -if-27-ifBody             
        Jump         -if-27-elseBody           
        Label        -if-27-ifBody             
        Jump         -for-elem-enter-15-continue-target 
        Jump         -if-27-join               
        Label        -if-27-elseBody           
        Label        -if-27-join               
        Label        -if-33-condition          
        Label        -compare-equal-28-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-28-arg2    
        PushI        2                         
        Label        -compare-equal-28-sub     
        Subtract                               
        JumpFalse    -compare-equal-28-true    
        Jump         -compare-equal-28-false   
        Label        -compare-equal-28-true    
        PushI        1                         
        Jump         -compare-equal-28-join    
        Label        -compare-equal-28-false   
        PushI        0                         
        Jump         -compare-equal-28-join    
        Label        -compare-equal-28-join    
        Duplicate                              
        JumpTrue     -SC-Or-30-short-circuit-true 
        Pop                                    
        Label        -compare-equal-29-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-29-arg2    
        PushI        3                         
        Label        -compare-equal-29-sub     
        Subtract                               
        JumpFalse    -compare-equal-29-true    
        Jump         -compare-equal-29-false   
        Label        -compare-equal-29-true    
        PushI        1                         
        Jump         -compare-equal-29-join    
        Label        -compare-equal-29-false   
        PushI        0                         
        Jump         -compare-equal-29-join    
        Label        -compare-equal-29-join    
        Jump         -SC-Or-30-end             
        Label        -SC-Or-30-short-circuit-true 
        Label        -SC-Or-30-end             
        JumpTrue     -if-33-ifBody             
        Jump         -if-33-elseBody           
        Label        -if-33-ifBody             
        PushD        $global-memory-block      
        PushI        0                         
        Add                                    %% print_str
        LoadI                                  
        CallV                                  
        Jump         -if-33-join               
        Label        -if-33-elseBody           
        Label        -if-32-condition          
        Label        -compare-equal-31-arg1    
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        LoadI                                  
        Label        -compare-equal-31-arg2    
        PushI        5                         
        Label        -compare-equal-31-sub     
        Subtract                               
        JumpFalse    -compare-equal-31-true    
        Jump         -compare-equal-31-false   
        Label        -compare-equal-31-true    
        PushI        1                         
        Jump         -compare-equal-31-join    
        Label        -compare-equal-31-false   
        PushI        0                         
        Jump         -compare-equal-31-join    
        Label        -compare-equal-31-join    
        JumpTrue     -if-32-ifBody             
        Jump         -if-32-elseBody           
        Label        -if-32-ifBody             
        PushD        $global-memory-block      
        PushI        12                        
        Add                                    %% print_str2
        LoadI                                  
        CallV                                  
        Jump         -if-32-join               
        Label        -if-32-elseBody           
        Label        -if-32-join               
        Label        -if-33-join               
        DLabel       -for-index-40-for-length  
        DataZ        4                         
        DLabel       -for-index-40-for-index   
        DataZ        4                         
        DLabel       -for-index-40-for-expr    
        DataZ        4                         
        DLabel       -for-index-40-for-subsize 
        DataZ        4                         
        DLabel       -for-index-40-for-indentifier 
        DataZ        4                         
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% points
        LoadI                                  
        Duplicate                              
        JumpFalse    $$null-array              
        Duplicate                              
        PushD        -for-index-40-for-expr    
        Exchange                               
        StoreI                                 
        PushI        12                        
        Add                                    
        LoadI                                  
        PushD        -for-index-40-for-length  
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        -for-index-40-for-index   
        Exchange                               
        StoreI                                 
        Label        -for-index-40-loop-start  
        PushD        -for-index-40-for-length  
        LoadI                                  
        PushD        -for-index-40-for-index   
        LoadI                                  
        Subtract                               
        JumpPos      -for-index-40-in-label    
        Jump         -for-index-40-exit        
        Label        -for-index-40-in-label    
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% j
        PushD        -for-index-40-for-index   
        LoadI                                  
        StoreI                                 
        Label        -if-36-condition          
        Label        -compare-equal-35-arg1    
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% j
        LoadI                                  
        Label        -compare-equal-35-arg2    
        PushI        2                         
        Label        -compare-equal-35-sub     
        Subtract                               
        JumpFalse    -compare-equal-35-true    
        Jump         -compare-equal-35-false   
        Label        -compare-equal-35-true    
        PushI        1                         
        Jump         -compare-equal-35-join    
        Label        -compare-equal-35-false   
        PushI        0                         
        Jump         -compare-equal-35-join    
        Label        -compare-equal-35-join    
        JumpTrue     -if-36-ifBody             
        Jump         -if-36-elseBody           
        Label        -if-36-ifBody             
        Jump         -for-index-enter-34-continue-target 
        Jump         -for-elem-enter-15-continue-target 
        Jump         -if-36-join               
        Label        -if-36-elseBody           
        Label        -if-36-join               
        Label        -if-38-condition          
        Label        -compare-equal-37-arg1    
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% j
        LoadI                                  
        Label        -compare-equal-37-arg2    
        PushI        8                         
        Label        -compare-equal-37-sub     
        Subtract                               
        JumpFalse    -compare-equal-37-true    
        Jump         -compare-equal-37-false   
        Label        -compare-equal-37-true    
        PushI        1                         
        Jump         -compare-equal-37-join    
        Label        -compare-equal-37-false   
        PushI        0                         
        Jump         -compare-equal-37-join    
        Label        -compare-equal-37-join    
        JumpTrue     -if-38-ifBody             
        Jump         -if-38-elseBody           
        Label        -if-38-ifBody             
        Jump         -for-index-enter-34-break-target 
        Jump         -for-elem-enter-15-break-target 
        Jump         -if-38-join               
        Label        -if-38-elseBody           
        Label        -if-38-join               
        PushD        $global-memory-block      
        PushI        8                         
        Add                                    %% i
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushD        $global-memory-block      
        PushI        4                         
        Add                                    %% points
        LoadI                                  
        PushD        $global-memory-block      
        PushI        16                        
        Add                                    %% j
        LoadI                                  
        PushD        $a-indexing-index         
        Exchange                               
        StoreI                                 
        PushD        $a-indexing-array         
        Exchange                               
        StoreI                                 
        PushD        $a-indexing-array         
        LoadI                                  
        JumpFalse    $$null-array              
        PushD        $a-indexing-index         
        LoadI                                  
        JumpNeg      $$index-out-of-bound      
        PushD        $a-indexing-index         
        LoadI                                  
        PushD        $a-indexing-array         
        LoadI                                  
        PushI        12                        
        Add                                    
        LoadI                                  
        Subtract                               
        JumpNeg      -array-indexing-39-in-bounds 
        Jump         $$index-out-of-bound      
        Label        -array-indexing-39-in-bounds 
        Nop                                    
        PushD        $a-indexing-array         
        LoadI                                  
        PushI        16                        
        Add                                    
        PushD        $a-indexing-index         
        LoadI                                  
        PushI        4                         
        Multiply                               
        Add                                    
        LoadI                                  
        PushD        $print-format-integer     
        Printf                                 
        PushI        1                         
        PushI        1                         
        Add                                    
        PushI        12                        
        Add                                    
        Call         -mem-manager-allocate     
        PushD        $record-creation-temp     
        Exchange                               
        StoreI                                 
        PushI        6                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        9                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        13                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        32                        
        PushD        $record-creation-temp     
        LoadI                                  
        PushI        12                        
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $record-creation-temp     
        LoadI                                  
        Call         $print-string             
        PushI        1                         
        PushD        -for-index-40-for-index   
        LoadI                                  
        Add                                    
        PushD        -for-index-40-for-index   
        Exchange                               
        StoreI                                 
        Jump         -for-index-40-loop-start  
        Label        -for-index-enter-34-break-target 
        Jump         -for-index-40-exit        
        Label        -for-index-enter-34-continue-target 
        PushI        1                         
        PushD        -for-index-40-for-index   
        LoadI                                  
        Add                                    
        PushD        -for-index-40-for-index   
        Exchange                               
        StoreI                                 
        Jump         -for-index-40-loop-start  
        Label        -for-index-40-exit        
        PushD        $print-format-newline     
        Printf                                 
        PushI        1                         
        PushD        -for-expr-41-for-index    
        LoadI                                  
        Add                                    
        PushD        -for-expr-41-for-index    
        Exchange                               
        StoreI                                 
        Jump         -for-expr-41-loop-start   
        Label        -for-elem-enter-15-break-target 
        Jump         -for-expr-41-exit         
        Label        -for-elem-enter-15-continue-target 
        PushI        1                         
        PushD        -for-expr-41-for-index    
        LoadI                                  
        Add                                    
        PushD        -for-expr-41-for-index    
        Exchange                               
        StoreI                                 
        Jump         -for-expr-41-loop-start   
        Label        -for-expr-41-exit         
        Halt                                   
        Label        -mem-manager-make-tags    
        DLabel       $mmgr-tags-size           
        DataZ        4                         
        DLabel       $mmgr-tags-start          
        DataZ        4                         
        DLabel       $mmgr-tags-available      
        DataZ        4                         
        DLabel       $mmgr-tags-nextptr        
        DataZ        4                         
        DLabel       $mmgr-tags-prevptr        
        DataZ        4                         
        DLabel       $mmgr-tags-return         
        DataZ        4                         
        PushD        $mmgr-tags-return         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-size           
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-start          
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-available      
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-nextptr        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-prevptr        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-tags-prevptr        
        LoadI                                  
        PushD        $mmgr-tags-size           
        LoadI                                  
        PushD        $mmgr-tags-available      
        LoadI                                  
        PushD        $mmgr-tags-start          
        LoadI                                  
        Call         -mem-manager-one-tag      
        PushD        $mmgr-tags-nextptr        
        LoadI                                  
        PushD        $mmgr-tags-size           
        LoadI                                  
        PushD        $mmgr-tags-available      
        LoadI                                  
        PushD        $mmgr-tags-start          
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        Call         -mem-manager-one-tag      
        PushD        $mmgr-tags-return         
        LoadI                                  
        Return                                 
        Label        -mem-manager-one-tag      
        DLabel       $mmgr-onetag-return       
        DataZ        4                         
        DLabel       $mmgr-onetag-location     
        DataZ        4                         
        DLabel       $mmgr-onetag-available    
        DataZ        4                         
        DLabel       $mmgr-onetag-size         
        DataZ        4                         
        DLabel       $mmgr-onetag-pointer      
        DataZ        4                         
        PushD        $mmgr-onetag-return       
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-location     
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-available    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-size         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-size         
        LoadI                                  
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        4                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $mmgr-onetag-available    
        LoadI                                  
        PushD        $mmgr-onetag-location     
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $mmgr-onetag-return       
        LoadI                                  
        Return                                 
        Label        -mem-manager-allocate     
        DLabel       $mmgr-alloc-return        
        DataZ        4                         
        DLabel       $mmgr-alloc-size          
        DataZ        4                         
        DLabel       $mmgr-alloc-current-block 
        DataZ        4                         
        DLabel       $mmgr-alloc-remainder-block 
        DataZ        4                         
        DLabel       $mmgr-alloc-remainder-size 
        DataZ        4                         
        PushD        $mmgr-alloc-return        
        Exchange                               
        StoreI                                 
        PushI        18                        
        Add                                    
        PushD        $mmgr-alloc-size          
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Label        -mmgr-alloc-process-current 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        JumpFalse    -mmgr-alloc-no-block-works 
        Label        -mmgr-alloc-test-block    
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Subtract                               
        PushI        1                         
        Add                                    
        JumpPos      -mmgr-alloc-found-block   
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Jump         -mmgr-alloc-process-current 
        Label        -mmgr-alloc-found-block   
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        Call         -mem-manager-remove-block 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Subtract                               
        PushI        26                        
        Subtract                               
        JumpNeg      -mmgr-alloc-return-userblock 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Add                                    
        PushD        $mmgr-alloc-remainder-block 
        Exchange                               
        StoreI                                 
        PushD        $mmgr-alloc-size          
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        4                         
        Add                                    
        LoadI                                  
        Exchange                               
        Subtract                               
        PushD        $mmgr-alloc-remainder-size 
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        0                         
        PushI        0                         
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushD        $mmgr-alloc-size          
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushI        0                         
        PushI        0                         
        PushI        1                         
        PushD        $mmgr-alloc-remainder-block 
        LoadI                                  
        PushD        $mmgr-alloc-remainder-size 
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushD        $mmgr-alloc-remainder-block 
        LoadI                                  
        PushI        9                         
        Add                                    
        Call         -mem-manager-deallocate   
        Jump         -mmgr-alloc-return-userblock 
        Label        -mmgr-alloc-no-block-works 
        PushD        $mmgr-alloc-size          
        LoadI                                  
        PushD        $mmgr-newblock-size       
        Exchange                               
        StoreI                                 
        PushD        $heap-after-ptr           
        LoadI                                  
        PushD        $mmgr-newblock-block      
        Exchange                               
        StoreI                                 
        PushD        $mmgr-newblock-size       
        LoadI                                  
        PushD        $heap-after-ptr           
        LoadI                                  
        Add                                    
        PushD        $heap-after-ptr           
        Exchange                               
        StoreI                                 
        PushI        0                         
        PushI        0                         
        PushI        0                         
        PushD        $mmgr-newblock-block      
        LoadI                                  
        PushD        $mmgr-newblock-size       
        LoadI                                  
        Call         -mem-manager-make-tags    
        PushD        $mmgr-newblock-block      
        LoadI                                  
        PushD        $mmgr-alloc-current-block 
        Exchange                               
        StoreI                                 
        Label        -mmgr-alloc-return-userblock 
        PushD        $mmgr-alloc-current-block 
        LoadI                                  
        PushI        9                         
        Add                                    
        PushD        $mmgr-alloc-return        
        LoadI                                  
        Return                                 
        Label        -mem-manager-deallocate   
        DLabel       $mmgr-dealloc-return      
        DataZ        4                         
        DLabel       $mmgr-dealloc-block       
        DataZ        4                         
        PushD        $mmgr-dealloc-return      
        Exchange                               
        StoreI                                 
        PushI        9                         
        Subtract                               
        PushD        $mmgr-dealloc-block       
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        JumpFalse    -mmgr-bypass-firstFree    
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -mmgr-bypass-firstFree    
        PushI        0                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushD        $heap-first-free          
        LoadI                                  
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        PushI        1                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushI        1                         
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        8                         
        Add                                    
        Exchange                               
        StoreC                                 
        PushD        $mmgr-dealloc-block       
        LoadI                                  
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        PushD        $mmgr-dealloc-return      
        LoadI                                  
        Return                                 
        Label        -mem-manager-remove-block 
        DLabel       $mmgr-remove-return       
        DataZ        4                         
        DLabel       $mmgr-remove-block        
        DataZ        4                         
        DLabel       $mmgr-remove-prev         
        DataZ        4                         
        DLabel       $mmgr-remove-next         
        DataZ        4                         
        PushD        $mmgr-remove-return       
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        LoadI                                  
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-remove-prev         
        Exchange                               
        StoreI                                 
        PushD        $mmgr-remove-block        
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        LoadI                                  
        PushD        $mmgr-remove-next         
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-process-prev 
        PushD        $mmgr-remove-prev         
        LoadI                                  
        JumpFalse    -mmgr-remove-no-prev      
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushD        $mmgr-remove-prev         
        LoadI                                  
        Duplicate                              
        PushI        4                         
        Add                                    
        LoadI                                  
        Add                                    
        PushI        9                         
        Subtract                               
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Jump         -mmgr-remove-process-next 
        Label        -mmgr-remove-no-prev      
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushD        $heap-first-free          
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-process-next 
        PushD        $mmgr-remove-next         
        LoadI                                  
        JumpFalse    -mmgr-remove-done         
        PushD        $mmgr-remove-prev         
        LoadI                                  
        PushD        $mmgr-remove-next         
        LoadI                                  
        PushI        0                         
        Add                                    
        Exchange                               
        StoreI                                 
        Label        -mmgr-remove-done         
        PushD        $mmgr-remove-return       
        LoadI                                  
        Return                                 
        DLabel       $heap-memory              
