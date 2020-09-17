# -*- coding: utf-8 -*-
"""
Created on Mon Dec  2 11:32:10 2019

@author: 11093
"""

import dash
from dash.dependencies import Output, Input
import dash_core_components as dcc
import dash_html_components as html
import plotly
import plotly.graph_objs as go
from collections import deque
import numpy as np
import scipy.io

data1 = scipy.io.loadmat('data.mat')['A'][0].tolist()
Y1 = data1

data2 = scipy.io.loadmat('data.mat')['B'][0].tolist()
Y2 = data2

data3 = scipy.io.loadmat('data.mat')['C'][0].tolist()
Y3 = data3

data4 = scipy.io.loadmat('data.mat')['D'][0].tolist()
Y4 = data4

data5 = scipy.io.loadmat('data.mat')['E'][0].tolist()
Y5 = data5

data6 = scipy.io.loadmat('data.mat')['F'][0].tolist()
Y6 = data6

data7 = scipy.io.loadmat('data.mat')['G'][0].tolist()
Y7 = data7

data8 = scipy.io.loadmat('data.mat')['H'][0].tolist()
Y8 = data8



X= np.linspace(0, 4, 1000,endpoint=False).tolist()

initial_trace1 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y1),
    name='ch1',
    mode='lines'
)
initial_trace2 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y2),
    xaxis='x2',
    yaxis='y2',
    name='ch2',
    mode='lines'
)
initial_trace3 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y3),
    xaxis='x3',
    yaxis='y3',
    name='ch3',
    mode='lines'
)
initial_trace4 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y4),
    xaxis='x4',
    yaxis='y4',
    name='ch4',
    mode='lines'
)
initial_trace5 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y5),
    xaxis='x5',
    yaxis='y5',
    name='ch5',
    mode='lines'
)
initial_trace6 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y6),
    xaxis='x6',
    yaxis='y6',
    name='ch6',
    mode='lines'
)
initial_trace7 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y7),
    xaxis='x7',
    yaxis='y7',
    name='ch7',
    mode='lines'
)
initial_trace8 = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y8),
    xaxis='x8',
    yaxis='y8',
    name='ch8',
    mode='lines'
)
app = dash.Dash(__name__)
app.layout = html.Div(
    [
        dcc.Graph(id='live-graph',
                  animate=True,
                  figure={'data': [initial_trace1,initial_trace2,initial_trace3,initial_trace4,initial_trace5,initial_trace6,initial_trace7,initial_trace8],
                          'layout': go.Layout(margin=go.Margin(l=80,r=80,b=100,t=30,pad=0),
                              autosize=False, width=1450, height=600,
                              xaxis=dict(domain=[0, 1]),
                              yaxis=dict(domain=[0.896,0.996],title="Amplitude"),
                              xaxis2=dict(domain=[0, 1], anchor='y2'),
                              yaxis2=dict(domain=[0.768, 0.868],anchor='x2'),
                              xaxis3=dict(domain=[0, 1], anchor='y3'),
                              yaxis3=dict(domain=[0.64, 0.74], anchor='x3'),
                              xaxis4=dict(domain=[0, 1], anchor='y4'),
                              yaxis4=dict(domain=[0.512, 0.612], anchor='x4'),
                              xaxis5=dict(domain=[0, 1], anchor='y5'),
                              yaxis5=dict(domain=[0.384, 0.484], anchor='x5'),
                              xaxis6=dict(domain=[0, 1], anchor='y6'),
                              yaxis6=dict(domain=[0.256, 0.356], anchor='x6'),
                              xaxis7=dict(domain=[0, 1], anchor='y7'),
                              yaxis7=dict(domain=[0.128, 0.228], anchor='x7'),
                              xaxis8=dict(domain=[0, 1], anchor='y8',title="time"),
                              yaxis8=dict(domain=[0, 0.1], anchor='x8')
                          ),
                          }),
        dcc.Interval(
            id='graph-update',
            interval=1*1000
        ),
    ]
)


@app.callback(Output('live-graph', 'figure'),
              [Input('graph-update', 'n_intervals')])
def update_graph_scatter(n):
    data1 = scipy.io.loadmat('data.mat')['A'][0].tolist()
    Y1 = data1

    data2 = scipy.io.loadmat('data.mat')['B'][0].tolist()
    Y2 = data2

    data3 = scipy.io.loadmat('data.mat')['C'][0].tolist()
    Y3 = data3

    data4 = scipy.io.loadmat('data.mat')['D'][0].tolist()
    Y4 = data4

    data5 = scipy.io.loadmat('data.mat')['E'][0].tolist()
    Y5 = data5

    data6 = scipy.io.loadmat('data.mat')['F'][0].tolist()
    Y6 = data6

    data7 = scipy.io.loadmat('data.mat')['G'][0].tolist()
    Y7 = data7

    data8 = scipy.io.loadmat('data.mat')['H'][0].tolist()
    Y8 = data8

    X = np.linspace(0, 4, 1000,endpoint=False).tolist()

    trace1 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y1),
        name='ch1',
        mode='lines'
    )
    trace2 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y2),
        xaxis='x2',
        yaxis='y2',
        name='ch2',
        mode='lines'
    )
    trace3 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y3),
        xaxis='x3',
        yaxis='y3',
        name='ch3',
        mode='lines'
    )
    trace4 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y4),
        xaxis='x4',
        yaxis='y4',
        name='ch4',
        mode='lines'
    )
    trace5 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y5),
        xaxis='x5',
        yaxis='y5',
        name='ch5',
        mode='lines'
    )
    trace6 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y6),
        xaxis='x6',
        yaxis='y6',
        name='ch6',
        mode='lines'
    )
    trace7 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y7),
        xaxis='x7',
        yaxis='y7',
        name='ch7',
        mode='lines'
    )
    trace8 = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y8),
        xaxis='x8',
        yaxis='y8',
        name='ch8',
        mode='lines'
    )
    return {'data': [trace1,trace2,trace3,trace4,trace5,trace6,trace7,trace8],
            'layout': go.Layout(margin=go.Margin(l=80,r=80,b=100,t=30,pad=0),
                autosize=False,width=1450,height=600,
                                xaxis=dict(domain=[0, 1]),
                                yaxis=dict(domain=[0.896, 0.996], title="Amplitude",range=[min(Y1),max(Y1)]),
                                xaxis2=dict(domain=[0, 1], anchor='y2'),
                                yaxis2=dict(domain=[0.768, 0.868], anchor='x2',range=[min(Y2),max(Y2)]),
                                xaxis3=dict(domain=[0, 1], anchor='y3'),
                                yaxis3=dict(domain=[0.64, 0.74], anchor='x3',range=[min(Y3),max(Y3)]),
                                xaxis4=dict(domain=[0, 1], anchor='y4'),
                                yaxis4=dict(domain=[0.512, 0.612], anchor='x4',range=[min(Y4),max(Y4)]),
                                xaxis5=dict(domain=[0, 1], anchor='y5'),
                                yaxis5=dict(domain=[0.384, 0.484], anchor='x5',range=[min(Y5),max(Y5)]),
                                xaxis6=dict(domain=[0, 1], anchor='y6'),
                                yaxis6=dict(domain=[0.256, 0.356], anchor='x6',range=[min(Y6),max(Y6)]),
                                xaxis7=dict(domain=[0, 1], anchor='y7'),
                                yaxis7=dict(domain=[0.128, 0.228], anchor='x7',range=[min(Y7),max(Y7)]),
                                xaxis8=dict(domain=[0, 1], anchor='y8', title="time"),
                                yaxis8=dict(domain=[0, 0.1], anchor='x8',range=[min(Y8),max(Y8)])
            )}


if __name__ == '__main__':
    app.run_server(port=8051, debug=True)


