
(function ($) {
    "use strict";


    /*==================================================================
    [ Validate ]*/
    var input = $('.validate-input .input100');

    $('.validate-form').on('submit',function(){
        var check = true;

        for(var i=0; i<input.length; i++) {
            if(validate(input[i]) == false){
                showValidate(input[i]);
                check=false;
            }
        }

        return check;
    });


    $('.validate-form .input100').each(function(){
        $(this).focus(function(){
           hideValidate(this);
        });
    });

    function validate (input) {
        if($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
            if($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
                return false;
            }
        }
        else {
            if($(input).val().trim() == ''){
                return false;
            }
        }
    }

    function showValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).addClass('alert-validate');
    }

    function hideValidate(input) {
        var thisAlert = $(input).parent();

        $(thisAlert).removeClass('alert-validate');
    }

    var util = {
        f: {
            addStyle: function (elem, prop, val, vendors) {
                var i, ii, property, value
                if (!util.f.isElem(elem)) {
                    elem = document.getElementById(elem)
                }
                if (!util.f.isArray(prop)) {
                    prop = [prop]
                    val = [val]
                }
                for (i = 0; i < prop.length; i += 1) {
                    var thisProp = String(prop[i]),
                        thisVal = String(val[i])
                    if (typeof vendors !== "undefined") {
                        if (!util.f.isArray(vendors)) {
                            vendors.toLowerCase() == "all" ? vendors = ["webkit", "moz", "ms", "o"] : vendors = [vendors]
                        }
                        for (ii = 0; ii < vendors.length; ii += 1) {
                            elem.style[vendors[i] + thisProp] = thisVal
                        }
                    }
                    thisProp = thisProp.charAt(0).toLowerCase() + thisProp.slice(1)
                    elem.style[thisProp] = thisVal
                }
            },
            cssLoaded: function (event) {
                var child = util.f.getTrg(event)
                child.setAttribute("media", "all")
            },
            events: {
                cancel: function (event) {
                    util.f.events.prevent(event)
                    util.f.events.stop(event)
                },
                prevent: function (event) {
                    event = event || window.event
                    event.preventDefault()
                },
                stop: function (event) {
                    event = event || window.event
                    event.stopPropagation()
                }
            },
            getPath: function (cb, args) {
                GLOBAL.path = window.location.href.split("masterdemolition")[1].replace("inc.com/admin/", "").replace("inc.com/admin", "").replace("#!/", "").replace("#!", "").replace("#/", "").replace("#", "")
                if (GLOBAL.path.indexOf("?") >= 0) {
                    GLOBAL.path = GLOBAL.path.split("?")[0]
                }
                if (typeof cb !== "undefined") {
                    typeof args !== "undefined" ? cb(args) : cb()
                } else {
                    return GLOBAL.path
                }
            },
            getSize: function (elem, prop) {
                return parseInt(elem.getBoundingClientRect()[prop], 10)
            },
            getTrg: function (event) {
                event = event || window.event
                if (event.srcElement) {
                    return event.srcElement
                } else {
                    return event.target
                }
            },
            isElem: function (elem) {
                return (util.f.isNode(elem) && elem.nodeType == 1)
            },
            isArray: function (v) {
                return (v.constructor === Array)
            },
            isNode: function (elem) {
                return (typeof Node === "object" ? elem instanceof Node : elem && typeof elem === "object" && typeof elem.nodeType === "number" && typeof elem.nodeName === "string" && elem.nodeType !== 3)
            },
            isObj: function (v) {
                return (typeof v == "object")
            },
            replaceAt: function (str, index, char) {
                return str.substr(0, index) + char + str.substr(index + char.length);
            }
        }
    },
     
    

})(jQuery);