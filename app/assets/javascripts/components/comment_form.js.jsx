var CommentForm = React.createClass({
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
        var order_id = this.props.id;
        var request = $.ajax({
            method: "POST",
            url: "comments",
            data: { order_id: order_id, comment: { content: content } }
        });
        request.done(function( msg ) {
            component.props.afterSuccess(component.props.id, msg)
        });
        request.fail(function( msg ) {
            var nextText = '';
            var nextError = msg.responseJSON;
            component.setState({text: nextText, error: nextError});
        });
    },
    render: function() {
        var alert;
        if (this.state.error != "") {
            alert = <div className="alert alert-danger">{this.state.error}</div>;
        }
        return (
            <form onSubmit={this.onSubmit}>
                <div className="input-group">
                    <input className="form-control" onChange={this.onChange} value={this.state.text} placeholder="Content" />
                    <span className="input-group-btn">
                        <button className="btn btn-default">Add comment</button>
                    </span>
                </div>
                {alert}
            </form>
        );
    }
});