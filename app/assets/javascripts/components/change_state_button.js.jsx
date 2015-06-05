var ChangeStateButton = React.createClass({
    handleSubmit: function(e) {
        e.preventDefault();
        var component = this;
        var state = this.props.newState;
        var id = this.props.id;
        var request = $.ajax({
            method: "POST",
            url: "change_order_state",
            data: { id: id, state: state }
        });
        request.done(function( msg ) {
            component.props.afterSuccess(component.props.id, msg);
        });
        request.fail(function( msg ) {
            console.log("Change state failed");
        });
    },
    render: function() {
        return (
            <div>
                <form onSubmit={this.handleSubmit}>
                    <button className="btn btn-xs btn-success">Change to {this.props.newState}</button>
                </form>
            </div>
        );
    }
});