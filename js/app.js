window.ee = new EventEmitter();

var my_news = [
    {
        author: 'Саша Печкин',
        text: 'В четчерг, четвертого числа...',
        bigText: 'в четыре с четвертью часа четыре чёрненьких чумазеньких чертёнка чертили чёрными чернилами чертёж.'
    },
    {
        author: 'Просто Вася',
        text: 'Считаю, что $ должен стоить 35 рублей!',
        bigText: 'А евро 42!'
    },
    {
        author: 'Гость',
        text: 'Бесплатно. Скачать. Лучший сайт - http://localhost:3000',
        bigText: 'На самом деле платно, просто нужно прочитать очень длинное лицензионное соглашение'
    }
];

var Article = React.createClass({
    propTypes: {
        data: React.PropTypes.shape({
            author: React.PropTypes.string.isRequired,
            text: React.PropTypes.string.isRequired,
            bigText: React.PropTypes.string.isRequired
        })
    },
    getInitialState: function () {
        return {
            visible: false
        }
    },
    readmoreClick: function () {
        this.setState({visible: true});
    },
    render: function () {
        var author = this.props.data.author,
          text = this.props.data.text,
          bigText = this.props.data.bigText,
          visible = this.state.visible;

        return (
          <div className='article'>
              <p className='news__author'>{author}:</p>
              <p className='news__text'>{text}</p>
              <a href="#" onClick={this.readmoreClick}
                 className={'news__readmore ' + (visible ? 'none' : '')}>Подробнее</a>
              <p className={'news__big-text ' + (visible ? '' : 'none')}>{bigText}</p>
          </div>
        )
    }
});

var News = React.createClass({
    propTypes: {
        data: React.PropTypes.array.isRequired
    },
    getInitialState: function () {
        return {
            counter: 0
        }
    },
    render: function () {
        var data = this.props.data;
        var newsTemplate;
        var counter = this.state.counter;

        if (data.length > 0) {
            newsTemplate = data.map(function (item, index) {
                return (
                  <div key={index}>
                      <Article data={item}/>
                  </div>
                )
            })
        } else {
            newsTemplate = <p>К сожалению новостей нет</p>
        }

        return (
          <div className='news'>
              {newsTemplate}
              <strong
                className={'news__count ' + (data.length > 0 ? '' : 'none') }
                onClick={ this.addNews }>
                  Всего новостей: { data.length }
              </strong>
          </div>
        );
    }
});

var App = React.createClass({
    getInitialState: function () {
        return {
            news: my_news
        }
    },
    componentDidMount: function () {
        var self = this;

        window.ee.addListener('News.add', function (item) {
            var nextNews = item.concat(self.state.news);
            self.setState({news: nextNews});
        });
    },
    componentWillUnmount: function () {
        window.ee.removeListener('News.add');
    },
    render: function () {
        return (
          <div className='app'>
              <Add />
              <h3>Новости</h3>
              <News data={this.state.news}/>
          </div>
        );
    }
});

var Add = React.createClass({
    componentDidMount: function () {
        ReactDOM.findDOMNode(this.refs.author).focus();
    },
    onBtnClickHandler: function (e) {
        e.preventDefault();
        var textEl = ReactDOM.findDOMNode(this.refs.text);
        var author = ReactDOM.findDOMNode(this.refs.author).value;
        var text = textEl.value;

        var item = [{
            author: author,
            text: text,
            bigText: '...'
        }];

        window.ee.emit('News.add', item);

        textEl.value = '';
        this.setState({emptyText: true});
    },
    onCheckRuleClick: function (e) {
        this.setState({agreeNotChecked: !this.state.agreeNotChecked}); //устанавливаем значение в state
    },
    getInitialState: function () {
        return {agreeNotChecked: true, emptyAuthor: true, emptyText: true}
    },
    onFieldChange: function (fieldName, e) {
        if (e.target.value.trim().length > 0) {
            this.setState({['' + fieldName]: false})
        } else {
            this.setState({['' + fieldName]: true})
        }
    },
    render: function () {
        return (
          <form className='add cf'>
              <input
                type='text'
                className='add__author'
                defaultValue=''
                placeholder='Ваше имя'
                ref='author'
                onChange={this.onFieldChange.bind(this, 'emptyAuthor')}
              />
              <textarea
                className='add__text'
                defaultValue=''
                placeholder='Текст новости'
                ref='text'
                onChange={this.onFieldChange.bind(this, 'emptyText')}
              ></textarea>
              <label className='add__checkrule'>
                  <input
                    type='checkbox'
                    ref='checkrule'
                    onChange={this.onCheckRuleClick}
                  />
                  Я согласен с правилами
              </label>
              <button
                className='add__btn'
                onClick={this.onBtnClickHandler}
                ref='alert_button'
                disabled={this.state.agreeNotChecked || this.state.emptyAuthor || this.state.emptyText }>
                  Добавить новость
              </button>
          </form>
        );
    }
});

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
