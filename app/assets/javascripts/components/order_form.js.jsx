var OrderForm = React.createClass({
    getInitialState: function() {
        return {text: '', error: ''};
    },
    onChange: function(e) {
        this.setState({text: e.target.value});
    },
    onSubmit: function(e) {
        e.preventDefault();
        var component = this;
        var content = this.state.text;
        var request = $.ajax({
            method: "POST",
            url: "orders",
            data: { order: { content: content, state: 'active' } }
        });
        request.done(function( msg ) {
            var nextText = '';
            var nextOrderAlert = '';
            component.setState({text: nextText,
                                error: nextOrderAlert});
            component.props.afterSuccess(msg);
        });
        request.fail(function( msg ) {
            var nextText = '';
            var nextOrderAlert = msg.responseJSON;
            component.setState({text: nextText,
                                error: nextOrderAlert});
        });
    },
    render: function() {
        var alert;
        if (this.state.error != "") {
            alert = <div className="alert alert-danger">{this.state.error}</div>;
        }
        return (
            <div>
                <form onSubmit={this.onSubmit}>
                    <div className="input-group">
                        <input className="form-control" onChange={this.onChange} value={this.state.text} placeholder="Content" />
                        <span className="input-group-btn">
                            <button className="btn btn-primary">Create new</button>
                        </span>
                    </div>
                </form>
                {alert}
            </div>
        );
    }
});