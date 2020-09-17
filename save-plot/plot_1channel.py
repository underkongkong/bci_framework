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

data = scipy.io.loadmat('data.mat')['A'][0].tolist()
Y = data
X= list(range(1000))
initial_trace = plotly.graph_objs.Scatter(
    x=list(X),
    y=list(Y),
    name='Scatter',
    mode='lines'
)

app = dash.Dash(__name__)
app.layout = html.Div(
    [
        dcc.Graph(id='live-graph',
                  animate=True,
                  figure={'data': [initial_trace],
                          'layout': go.Layout(
                              xaxis=dict(range=[min(X), max(X)]),
                              yaxis=dict(range=[-0.003, 0.003]))
                          }),
        dcc.Interval(
            id='graph-update',
            interval=1*200
        ),
    ]
)


@app.callback(Output('live-graph', 'figure'),
              [Input('graph-update', 'n_intervals')])
def update_graph_scatter(n):
    data = scipy.io.loadmat('data.mat')['A'][0].tolist()
    Y = data
    X = list(range(1000))

    trace = plotly.graph_objs.Scatter(
        x=list(X),
        y=list(Y),
        name='Scatter',
        mode='lines'
    )

    return {'data': [trace],
            'layout': go.Layout(
                xaxis=dict(range=[min(X), max(X)]),
                yaxis=dict(range=[-0.003, 0.003]))
            }


if __name__ == '__main__':
    app.run_server(port=8051, debug=True)