var OrderPanel = function(order, index) {
    var panelClass;
    var finalizeButton;
    var orderedButton;
    var deliveredButton;
    var commentForm;
    if(order.state == 'active') {
        panelClass = 'panel panel-success';
        finalizeButton = <ChangeStateButton id={order.id} newState="finalized" afterSuccess={this.handleFinalize} />
        if (order.can_comment) {
            commentForm = <CommentForm id={order.id} afterSuccess={this.handleNewComment} />;
        }
    }
    else {
        panelClass = 'panel panel-danger';
        if(order.state == 'finalized') {
            orderedButton = <ChangeStateButton id={order.id} newState="ordered" afterSuccess={this.handleStateChange} />
        }
        if(order.state == 'ordered') {
            deliveredButton = <ChangeStateButton id={order.id} newState="delivered" afterSuccess={this.handleStateChange} />
        }
    }
    var commentLine = function(comment, index) {
        return (
            <li className="list-group-item">
                <div className="row">
                    <div className="col-md-3">
                        <img src={comment.user_image} />
                    </div>
                    <div className="col-md-3">
                        {comment.time}
                    </div>
                    <div className="col-md-6 break-words">
                        <strong>{comment.content}</strong>
                    </div>
                </div>
            </li>
        )
    };
    return (
        <div className={panelClass}>
            <div className="panel-heading">
                <div className="row">
                    <div className="col-md-4">{order.day}</div>
                    <div className="col-md-4">{order.state} since {order.time}</div>
                    <div className="col-md-4">
                        {finalizeButton}
                        {orderedButton}
                        {deliveredButton}
                    </div>
                </div>
            </div>
            <div className="panel-body">
                <div className="row">
                    <div className="col-md-3"><img src={order.user_image} /></div>
                    <div className="col-md-3"><h4>{order.created_at}</h4></div>
                    <div className="col-md-6 break-words"><h4>{order.content}</h4></div>
                </div>
            </div>
            <ul className="list-group">
                {order.comments.map(commentLine)}
            </ul>
            {commentForm}
        </div>
    );
};