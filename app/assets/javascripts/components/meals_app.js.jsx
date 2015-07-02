var MealsApp = React.createClass({
    getInitialState: function() {
        return {activeOrders: this.props.activeOrders,
                finalizedOrders: this.props.finalizedOrders,
                timer: 5,
                autorefreshAlert: ''};
    },
    tick: function() {
        var component = this;
        var newTimer = (this.state.timer - 1);
        if (newTimer < 1) {
            var request = $.ajax({
                method: "GET",
                url: "orders"
            });
            request.done(function( msg ) {
                var nextActiveOrder = msg.activeOrders;
                var nextFinalizedOrder = msg.finalizedOrders;
                var nextAutoRefreshAlert = '';
                component.setState({activeOrders: nextActiveOrder,
                            finalizedOrders: nextFinalizedOrder,
                            autorefreshAlert: nextAutoRefreshAlert});
            });
            request.fail(function( msg ) {
                var nextAutoRefreshAlert = 'Last autorefresh failed';
                component.setState({autorefreshAlert: nextAutoRefreshAlert});
            });
            newTimer = 5;
        }
        this.setState({timer: newTimer});
    },
    componentDidMount: function() {
        this.interval = setInterval(this.tick, 1000);
    },
    componentWillUnmount: function() {
        clearInterval(this.interval);
    },
    handleNewOrder: function( msg ) {
        var nextFinalizedOrder = [msg].concat(this.state.activeOrders);
        this.setState({activeOrders: nextFinalizedOrder});
    },
    handleFinalize: function(orderId, newOrder) {
        var newFinalizedOrders = [newOrder].concat(this.state.finalizedOrders);
        this.setState({finalizedOrders: newFinalizedOrders});

        var newActiveOrders = this.state.activeOrders.filter(function(order) {
            return order.id != orderId
        });
        this.setState({activeOrders: newActiveOrders});
    },
    handleStateChange: function(orderId, newOrder) {
        var newFinalizedOrders = this.state.finalizedOrders;
        var index;
        for (index = 0; index < newFinalizedOrders.length; ++index) {
            if (newFinalizedOrders[index].id == orderId)
                newFinalizedOrders[index] = newOrder;
        }
        this.setState({finalizedOrders: newFinalizedOrders});
    },
    handleNewComment: function(orderId, newOrder) {
        var newActiveOrders = this.state.activeOrders;
        var index;
        for (index = 0; index < newActiveOrders.length; ++index) {
            if (newActiveOrders[index].id == orderId)
                newActiveOrders[index] = newOrder;
        }
        this.setState({activeOrders: newActiveOrders});
    },
    render: function() {
        var autorefreshAlert;
        if (this.state.autorefreshAlert != "") {
            autorefreshAlert = <div className="alert alert-danger">{this.state.autorefreshAlert}</div>;
        }
        return (
            <div>
                {autorefreshAlert}
                <div>Time to autorefresh: {this.state.timer}</div>
                <div className="row">
                    <div className="col-md-6">
                        <div>
                            <h3>Active orders</h3>
                                <OrderForm afterSuccess={this.handleNewOrder} />
                            <div>
                                {this.state.activeOrders.map(OrderPanel, this)}
                            </div>
                        </div>
                    </div>
                    <div className="col-md-6">
                        <div>
                            <h3>History</h3>
                            <div>
                                {this.state.finalizedOrders.map(OrderPanel, this)}
                            </div>
                        </div>
                    </div>
                </div>
           </div>
        )
    }
});