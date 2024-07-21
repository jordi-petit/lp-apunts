import streamlit as st

s = '''
graph g {
n1 [label="@"]
n2 [label="λ"]
n1 -- n2
n3 [label="@"]
n1 -- n3
n4 [label="y"]
n2 -- n4
n5 [label="@"]
n2 -- n5
n6 [label="a"]
n3 -- n6
n7 [label="b"]
n3 -- n7
n8 [label="x"]
n5 -- n8
n9 [label="@"]
n5 -- n9
n10 [label="y"]
n9 -- n10
n11 [label="z"]
n9 -- n11
}

'''

st.graphviz_chart(s)
