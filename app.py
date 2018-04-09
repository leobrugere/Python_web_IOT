#!/usr/bin/env python3.5
#-*- coding: utf-8 -*

from passlib.hash import argon2
from flask import Flask, render_template, request, g, session, redirect, url_for
import mysql.connector

#Création de l'appli Flask qu'on stocke dans projet_web
app = Flask(__name__)
app.config.from_object('config')
app.config.from_object('secret_config')

def connect_db () :
    g.mysql_connection = mysql.connector.connect(
        host = app.config['DATABASE_HOST'],
        user = app.config['DATABASE_USER'],
        password = app.config['DATABASE_PASSWORD'],
        database = app.config['DATABASE_NAME']
    )
    g.mysql_cursor = g.mysql_connection.cursor()
    return g.mysql_cursor

def get_db () :
    if not hasattr(g, 'db') :
        g.db = connect_db()
    return g.db

@app.route('/add/', methods= ['POST', 'GET'])
def add():
    if request.method == 'POST':
        url_du_site = request.form.get('url_du_site')
        nom_site = request.form.get('nom')
        db = get_db()
        db.execute('INSERT INTO liste_site (lien, nom) VALUES (%(url_du_site)s, %(nom)s)', {'url_du_site' : url_du_site, 'nom' : nom_site})
        g.mysql_connection.commit()

    return render_template('add.html')

@app.route('/')
def index():
    db = get_db()
    db.execute('SELECT l.id, lien, l.nom, etats, date FROM etats_site e, liste_site l WHERE e.website_id = l.id AND date = (SELECT MAX(date) from etats_site e2 where e2.website_id = l.id) GROUP BY lien, l.id, e.etats, l.nom, e.date')
    link = db.fetchall()

    return render_template('index.html', link = link)


@app.route('/login/', methods = ['GET', 'POST'])
def login () :
    nom = str(request.form.get('nom'))
    password = str(request.form.get('password'))

    db = get_db()
    db.execute('SELECT nom, password, is_admin FROM users WHERE nom = %(nom)s', {'nom' : nom})
    users = db.fetchall()

    valid_user = False
    for user in users :
        if argon2.verify(password, user[1]) :
            valid_user = user
     
    if valid_user :
        session['user'] = valid_user
        return redirect(url_for('admin'))

    return render_template('login.html')

@app.route('/admin/')
def admin () :
    if not session.get('user') or not session.get('user')[2] :
        return redirect(url_for('login'))

    db = get_db()
    db.execute('SELECT l.id, lien, l.nom, etats, date FROM etats_site e, liste_site l WHERE e.website_id = l.id AND date = (SELECT MAX(date) from etats_site e2 where e2.website_id = l.id) GROUP BY lien, l.id, e.etats, l.nom, e.date')
    link = db.fetchall()

    return render_template('admin.html', user = session['user'], link = link)

@app.route('/admin/logout/')
def admin_logout () :
    session.clear()
    return redirect(url_for('login'))

@app.route('/details/<int:id>')
def details(id):

    db = get_db()
    db.execute('SELECT etats, date, nom FROM etats_site e JOIN liste_site l ON (e.website_id = l.id) WHERE website_id = %(id)s', {'id' : id})
    det = db.fetchall()

    return render_template('details.html', det = det)

@app.route('/supprimer/<int:id>/')
def supprimer(id):
    db = get_db()
    db.execute('DELETE FROM liste_site WHERE id = %(id)s', {'id' : id})
    g.mysql_connection.commit()

    return redirect(url_for('admin'))



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
