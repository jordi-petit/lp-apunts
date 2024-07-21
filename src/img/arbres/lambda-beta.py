import streamlit as st

s = '''
graph g {
n1 [label="@" color="blue" fontcolor="blue"]
n2 [label="λ" color="blue" fontcolor="blue"]
n1 -- n2 [ color="blue"]
n3 [label="ab"]
n1 -- n3
n4 [label="y"]
n2 -- n4
n5 [label="x(yz)"]
n2 -- n5
}

'''

st.graphviz_chart(s)
