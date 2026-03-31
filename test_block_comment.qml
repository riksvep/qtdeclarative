import QtQuick

/*
* broken *-style without initial space
*/
Item {
    /*
     * This is a test comment
     * with multiple lines
     * using star style
     */
    property int foo: 42

/*
 * This is a test comment
 * with multiple lines
 * using star style
 * with an improperly indented variable
 */
property int baz: 69


    function bar() {
        /*
         * Another block comment
         * in a function
         */
        return foo * 2
    }
}
